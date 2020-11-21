OzMedsTraitsBundle.Service.ZBootstrap = {}

---@private
---@return OzMedsTraitsBundle.Service.ZBootstrap
function OzMedsTraitsBundle.Service.ZBootstrap:new()
    ---@class OzMedsTraitsBundle.Service.ZBootstrap
    local public = {}
    local private = {}
    ---@type Container
    private.container = OzMedsCoreBundle.ZCore:getContainer()

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'OzMedsTraitsBundle.Service.ZBootstrap'

    ---@type Logger
    local logger = private.container:get('OzMedsCoreBundle.Service.Logger.Logger')
    logger:info('OZ Meds Traits Bundle successfully loaded!')

    return public
end

--Load bootstrap after all files are initialized
Events.OnGameBoot.Add(
    function()
        --no need to store this class in a container
        OzMedsTraitsBundle.Service.ZBootstrap = OzMedsTraitsBundle.Service.ZBootstrap:new()
    end
)
