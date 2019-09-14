------ MADE BY MAX F. ------
--FOR JUSTICE COMMUNITY RP--
----------------------------



----------------------------------------------------------------------------------------------------
--------------------------------------CREATING  THE  MENUS------------------------------------------
----------------------------------------------------------------------------------------------------

_mainPool = NativeUI.CreatePool()

SprunkMenu = NativeUI.CreateMenu( 'Sprunk', 'Sprunk Vending Machine')
_mainPool:Add(SprunkMenu)

eColaMenu = NativeUI.CreateMenu( 'eCola', 'eCola Vending Machine')
_mainPool:Add(eColaMenu)

CandyboxMenu = NativeUI.CreateMenu( 'CandyBox', 'CandyBox Vending Machine')
_mainPool:Add(CandyboxMenu)

BeanMenu = NativeUI.CreateMenu( 'Bean', 'Bean Vending Machine')
_mainPool:Add(BeanMenu)

RaineMenu = NativeUI.CreateMenu( 'Raine', 'Raine Vending Machine')
_mainPool:Add(RaineMenu)

------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------FUNCTIONS----------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------

function ShowNotification(message)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(true, false)
end

function Alert(message)
    SetTextComponentFormat('STRING')
    AddTextComponentString(message)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

function drawMarker(x, y, z, red, green, blue) --DrawMarker wrapper
    DrawMarker(1, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.25, red, green, blue, 100, false, true, 2, false, nil, nil, false)
end

function SubMenuAdd(menuPool, menu, Items)
    for i, m in ipairs(Items) do
        local _Item = NativeUI.CreateItem(Items[i].name, 'Price: ' .. Items[i].price)
        menu:AddItem(_Item)
        _Item.Activated = function(sender, item)
            if item == _Item then
                ShowNotification('+1 ' .. Items[i].name)
                -- add to database // inventory
            end
        end        
    end
end


----------------------------------------------------------------------------------------------------
-------------------------------------------Marker Handler-------------------------------------------
----------------------------------------------------------------------------------------------------

function MarkerHandler(Menu, Locations, name, R, G, B)
    for k, v in ipairs(Locations) do
        drawMarker(Locations[k].x, Locations[k].y, Locations[k].z, R, G, B)
        mycoords = GetEntityCoords(PlayerPedId(), true)
        if GetDistanceBetweenCoords(Locations[k].x, Locations[k].y, Locations[k].z, mycoords.x, mycoords.y, mycoords.z, true) < 1.2 then
            Alert('Press ~INPUT_TALK~ to access ' .. name .. '.')
            if IsControlJustPressed(1, 51) then -- E
                Menu:Visible(not Menu:Visible())
            end
        end
    end
end


----------------------------------------------------------------------------------------------------
---------------------------------------------MENUS SHIT---------------------------------------------
----------------------------------------------------------------------------------------------------

SubMenuAdd(_mainPool, SprunkMenu, sprunkItems)
SubMenuAdd(_mainPool, eColaMenu, ecolaItems)
SubMenuAdd(_mainPool, CandyboxMenu, candyboxItems)
SubMenuAdd(_mainPool, BeanMenu, beanItems)
SubMenuAdd(_mainPool, RaineMenu, raineItems)


_mainPool:RefreshIndex()

----------------------------------------------------------------------------------------------------
-------------------------------------------Markers Maker--------------------------------------------
----------------------------------------------------------------------------------------------------

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(0)
        _mainPool:ProcessMenus()
        MarkerHandler(SprunkMenu, sprunkLocations,'Sprunk vending machine', 53, 182, 59 )
        MarkerHandler(eColaMenu, ecolaLocations,'eCola vending machine', 143, 0, 17 )
        MarkerHandler(CandyboxMenu, candyboxLocations,'CandyBox vending machine', 255, 255, 255 )
        MarkerHandler(BeanMenu, coffeeLocations,'Bean vending machine', 43, 34, 25 )
        MarkerHandler(RaineMenu, raineLocations,'Raine vending machine', 50, 89, 126 )
    end
end)