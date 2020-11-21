---@type Trait
OzMedsTraitsBundle.Entity.Trait = {}

---Trait entity
---@param T table<string, any>
---@return Trait
function OzMedsTraitsBundle.Entity.Trait:new(T)
    ---@class Trait : Entity
    local public = {}
    local private = {}

    ---@type number
    private.cost = T.cost
    ---@type string[]
    private.freeRecipes = T.freeRecipes
    ---@type string[]
    private.freeTraits = T.freeTraits
    ---@type string[]
    private.xpBoosts = T.xpBoosts
    ---@type number[]
    private.xpBoostValues = T.xpBoostValues
    ---@type string[]
    private.mutualExclusives = T.mutualExclusives

    ---Get cost of this trait
    ---@return number
    function public:getCost()
        return private.cost
    end

    ---Get array of free recipe aliases
    ---@return string[]
    function public:getFreeRecipes()
        return private.freeRecipes
    end

    ---Get array of free trait aliases
    ---@return string[]
    function public:getFreeTraits()
        return private.freeTraits
    end

    ---Get array of all proficient skills
    ---@return string[]
    function public:getXpBoosts()
        return private.xpBoosts
    end

    ---Get array of all proficient skills xp modifier
    ---@return number[]
    function public:getXpBoostValues()
        return private.xpBoostValues
    end

    ---Get array of all excluded traits
    ---@return string[]
    function public:getMutualExclusives()
        return private.mutualExclusives
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'OzMedsTraitsBundle.Entity.Trait'

    extend(public, OzMedsCoreBundle.Component.Entity.Entity:new(T))

    return public
end