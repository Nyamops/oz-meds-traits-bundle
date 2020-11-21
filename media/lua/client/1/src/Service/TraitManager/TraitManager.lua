---@type TraitManager
OzMedsTraitsBundle.Service.TraitManager.TraitManager = {}

---@return TraitManager
function OzMedsTraitsBundle.Service.TraitManager.TraitManager:new()
    ---@type Container
    local Container = OzMedsCoreBundle.ZCore:getContainer()
    ---@class TraitManager
    local public = {}
    local private = {}

    ---@type Logger
    private.logger = Container:get('OzMedsCoreBundle.Service.Logger.Logger')
    ---@type function
    private.doTraits = BaseGameCharacterDetails.DoTraits
    ---@type Trait[]
    private.traits = Container:getByTag('oz_meds.traits_bundle.trait')

    BaseGameCharacterDetails.DoTraits = function()
        for _, trait in pairs(private.traits) do
            local originGameTrait = TraitFactory.addTrait(
                getmetatable(trait),
                trait:getName(),
                trait:getCost(),
                trait:getDescription(),
                false
            )

            private.logger:debug(
                string.format('New trait %s added to UI', trait:getName())
            )

            if #trait:getXpBoosts() > 0 then
                private:addXpBoost(trait, originGameTrait)
            end

            if #trait:getFreeRecipes() > 0 then
                private:addFreeRecipes(trait, originGameTrait)
            end

            if #trait:getFreeTraits() > 0 then
                private:addFreeTraits(trait, originGameTrait)
            end
        end

        for _, trait in pairs(private.traits) do
            if #trait:getMutualExclusives() > 0 then
                private:addMutualExclusives(trait)
            end
        end

        return private.doTraits(self)
    end

    function private:addXpBoost(trait, originGameTrait)
        for index, perkName in ipairs(trait:getXpBoosts()) do
            local boostLevel = trait:getXpBoostValues()[index]
            originGameTrait:addXPBoost(perkName, boostLevel)
        end
    end

    function private:addFreeRecipes(trait, originGameTrait)
        for _, recipeName in ipairs(trait:getFreeRecipes()) do
            originGameTrait:getFreeRecipes():add(recipeName)
        end
    end

    function private:addFreeTraits(trait, originGameTrait)
        for _, freeTraitName in ipairs(trait:getFreeTraits()) do
            originGameTrait:addFreeTrait(freeTraitName)
        end
    end

    function private:addMutualExclusives(trait)
        for _, exclusiveTraitName in ipairs(trait:getMutualExclusives()) do
            TraitFactory.setMutualExclusive(trait:getName(), exclusiveTraitName)
        end
    end

    BaseGameCharacterDetails.DoTraits()

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'OzMedsTraitsBundle.Service.TraitManager.TraitManager'

    return public
end

Events.OnGameBoot.Add(
    function()
        --no need to store this class in a container
        OzMedsTraitsBundle.Service.TraitManager.TraitManager = OzMedsTraitsBundle.Service.TraitManager.TraitManager:new()
    end
)