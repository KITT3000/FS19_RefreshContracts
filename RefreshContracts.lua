RefreshContracts = {}

RefreshContracts.debug = false --true --

function RefreshContracts:onFrameOpen()
    if RefreshContracts.debug then print("RefreshContracts:onFrameOpen") end

    local inGameMenu = g_currentMission.inGameMenu
    if inGameMenu.refreshContractsElement_Button == nil then
        -- Add a new docked button with a new action for refreshing the list
        local refreshContractsElement = inGameMenu.menuButton[1]:clone(self)
        refreshContractsElement:setText(g_i18n:getText("RefreshContracts_REFRESH"))
        refreshContractsElement:setInputAction("MENU_EXTRA_1")
        refreshContractsElement.onClickCallback = function(dialog)
            if RefreshContracts.debug then print("RefreshContracts:onClickCallback") end
            -- Set generationTimer to 0 so missions will be refresh at next update
            g_missionManager.generationTimer = 0
        end

        inGameMenu.menuButton[1].parent:addElement(refreshContractsElement)
        inGameMenu.refreshContractsElement_Button = refreshContractsElement
    end
end
InGameMenuContractsFrame.onFrameOpen = Utils.appendedFunction(InGameMenuContractsFrame.onFrameOpen, RefreshContracts.onFrameOpen)

function RefreshContracts:onFrameClose()
    if RefreshContracts.debug then print("RefreshContracts:onFrameClose") end

    local inGameMenu = g_currentMission.inGameMenu
    if inGameMenu.refreshContractsElement_Button ~= nil then
        inGameMenu.refreshContractsElement_Button:unlinkElement()
        inGameMenu.refreshContractsElement_Button:delete()
        inGameMenu.refreshContractsElement_Button = nil
    end
end
InGameMenuContractsFrame.onFrameClose = Utils.appendedFunction(InGameMenuContractsFrame.onFrameClose, RefreshContracts.onFrameClose)
