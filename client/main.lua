  local PlayerData              = {}
  local HasAlreadyEnteredMarker = false
  local LastStation             = nil
  local LastPart                = nil
  local LastPartNum             = nil
  local LastEntity              = nil
  local CurrentAction           = nil
  local CurrentActionMsg        = ''
  local CurrentActionData       = {}
  local IsHandcuffed            = false
  local DidCuff				  = false
  local HandcuffTimer           = {}
  local DragStatus              = {}
  DragStatus.IsDragged          = false
  local hasAlreadyJoined        = false
  local blipsCops               = {}
  local isDead                  = false
  local CurrentTask             = {}
  local playerInService         = false
  
  ESX                           = nil
  
  Citizen.CreateThread(function()
      while ESX == nil do
          TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
          Citizen.Wait(0)
      end
  
      while ESX.GetPlayerData().job == nil do
          Citizen.Wait(10)
      end
  
      PlayerData = ESX.GetPlayerData()
  end)
  
  function SetVehicleMaxMods(vehicle)
      local props = {
          modEngine       = 3,
          modBrakes       = 2,
          modTransmission = 2,
          modSuspension   = 3,
          modTurbo        = true
      }
  
      ESX.Game.SetVehicleProperties(vehicle, props)
  end
  
  function cleanPlayer(playerPed)
      SetPedArmour(playerPed, 0)
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)
      ResetPedMovementClipset(playerPed, 0)
  end
  
  function setUniform(job, playerPed)
      TriggerEvent('skinchanger:getSkin', function(skin)
          if skin.sex == 0 then
              if Config.Uniforms[job].male ~= nil then
                  TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
              else
                  ESX.ShowNotification(_U('no_outfit'))
              end
          else
              if Config.Uniforms[job].female ~= nil then
                  TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
              else
                  ESX.ShowNotification(_U('no_outfit'))
              end
          end
      end)
  end
  
  function OpenKledingActionsMenu()
      local elements = {
          {label = _U('kleding'), value = 'kleding'}
      }
  
      if Config.EnablePlayerManagement and (ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'kmar15') then
          table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
      end
  
      ESX.UI.Menu.CloseAll()
  
      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'kleding',
      {
          title		= _U('kleding'),
          align		= 'top-right',
          elements	= elements
      }, function(data, menu)
          if data.current.value == 'kleding' then
              OpenCloakroomMenu()
          elseif data.current.value == 'boss_actions' then
              TriggerEvent('esx_society:openBossMenu', 'kleding', function(data, menu)
                  menu.close()
              end, {wash = false})
          end
      end, function(data, menu)
          menu.close()
  
          CurrentAction		= 'kleding_actions_menu'
          CurrentActionMsg	= _U('open_menu')
          CurrentActionData	= {}
      end)
  end
  
  function OpenCloakroomMenu()
  
      local playerPed = PlayerPedId()
      local grade = PlayerData.job.grade_name
  
      local elements = {
          { label = _U('citizen_wear'), value = 'citizen_wear' }
      }
  
      if grade == 'aspirant' then
          table.insert(elements, {label = _U('kortnh_wear'), value = 'kortnh_wear'})
          table.insert(elements, {label = _U('langnh_wear'), value = 'langnh_wear'})
          table.insert(elements, {label = _U('verkeerkort_wear'), value = 'verkeerkort_wear'})
          table.insert(elements, {label = _U('verkeerlang_wear'), value = 'verkeerlang_wear'})
          table.insert(elements, {label = _U('ovdpkort_wear'), value = 'ovdpkort_wear'})
          table.insert(elements, {label = _U('ovdplang_wear'), value = 'ovdplang_wear'})
          table.insert(elements, {label = _U('motor_wear'), value = 'motor_wear'})
          table.insert(elements, {label = _U('unmarked_wear'), value = 'unmarked_wear'})
          table.insert(elements, {label = "DSI Outfit", value = 'dsi_wear'})
      elseif grade == 'surveillant' then
          table.insert(elements, {label = _U('kortnh_wear'), value = 'kortnh_wear'})
          table.insert(elements, {label = _U('langnh_wear'), value = 'langnh_wear'})
          table.insert(elements, {label = _U('verkeerkort_wear'), value = 'verkeerkort_wear'})
          table.insert(elements, {label = _U('verkeerlang_wear'), value = 'verkeerlang_wear'})
          table.insert(elements, {label = _U('ovdpkort_wear'), value = 'ovdpkort_wear'})
          table.insert(elements, {label = _U('ovdplang_wear'), value = 'ovdplang_wear'})
          table.insert(elements, {label = _U('motor_wear'), value = 'motor_wear'})
          table.insert(elements, {label = _U('unmarked_wear'), value = 'unmarked_wear'})
          table.insert(elements, {label = "DSI Outfit", value = 'dsi_wear'})
      elseif grade == 'agent' then
          table.insert(elements, {label = _U('kortnh_wear'), value = 'kortnh_wear'})
          table.insert(elements, {label = _U('langnh_wear'), value = 'langnh_wear'})
          table.insert(elements, {label = _U('verkeerkort_wear'), value = 'verkeerkort_wear'})
          table.insert(elements, {label = _U('verkeerlang_wear'), value = 'verkeerlang_wear'})
          table.insert(elements, {label = _U('ovdpkort_wear'), value = 'ovdpkort_wear'})
          table.insert(elements, {label = _U('ovdplang_wear'), value = 'ovdplang_wear'})
          table.insert(elements, {label = _U('motor_wear'), value = 'motor_wear'})
          table.insert(elements, {label = _U('unmarked_wear'), value = 'unmarked_wear'})
          table.insert(elements, {label = "DSI Outfit", value = 'dsi_wear'})
      elseif grade == 'hoofdagent' then
          table.insert(elements, {label = _U('kortnh_wear'), value = 'kortnh_wear'})
          table.insert(elements, {label = _U('langnh_wear'), value = 'langnh_wear'})
          table.insert(elements, {label = _U('verkeerkort_wear'), value = 'verkeerkort_wear'})
          table.insert(elements, {label = _U('verkeerlang_wear'), value = 'verkeerlang_wear'})
          table.insert(elements, {label = _U('ovdpkort_wear'), value = 'ovdpkort_wear'})
          table.insert(elements, {label = _U('ovdplang_wear'), value = 'ovdplang_wear'})
          table.insert(elements, {label = _U('motor_wear'), value = 'motor_wear'})
          table.insert(elements, {label = _U('unmarked_wear'), value = 'unmarked_wear'})
          table.insert(elements, {label = "DSI Outfit", value = 'dsi_wear'})
      elseif grade == 'brigadier' then
          table.insert(elements, {label = _U('kortnh_wear'), value = 'kortnh_wear'})
          table.insert(elements, {label = _U('langnh_wear'), value = 'langnh_wear'})
          table.insert(elements, {label = _U('verkeerkort_wear'), value = 'verkeerkort_wear'})
          table.insert(elements, {label = _U('verkeerlang_wear'), value = 'verkeerlang_wear'})
          table.insert(elements, {label = _U('ovdpkort_wear'), value = 'ovdpkort_wear'})
          table.insert(elements, {label = _U('ovdplang_wear'), value = 'ovdplang_wear'})
          table.insert(elements, {label = _U('motor_wear'), value = 'motor_wear'})
          table.insert(elements, {label = _U('unmarked_wear'), value = 'unmarked_wear'})
          table.insert(elements, {label = "DSI Outfit", value = 'dsi_wear'})
      elseif grade == 'inspecteur' then
          table.insert(elements, {label = _U('kortnh_wear'), value = 'kortnh_wear'})
          table.insert(elements, {label = _U('langnh_wear'), value = 'langnh_wear'})
          table.insert(elements, {label = _U('verkeerkort_wear'), value = 'verkeerkort_wear'})
          table.insert(elements, {label = _U('verkeerlang_wear'), value = 'verkeerlang_wear'})
          table.insert(elements, {label = _U('ovdpkort_wear'), value = 'ovdpkort_wear'})
          table.insert(elements, {label = _U('ovdplang_wear'), value = 'ovdplang_wear'})
          table.insert(elements, {label = _U('motor_wear'), value = 'motor_wear'})
          table.insert(elements, {label = _U('unmarked_wear'), value = 'unmarked_wear'})
          table.insert(elements, {label = "DSI Outfit", value = 'dsi_wear'})
      elseif grade == 'hoofdinspecteur' then
          table.insert(elements, {label = _U('kortnh_wear'), value = 'kortnh_wear'})
          table.insert(elements, {label = _U('langnh_wear'), value = 'langnh_wear'})
          table.insert(elements, {label = _U('verkeerkort_wear'), value = 'verkeerkort_wear'})
          table.insert(elements, {label = _U('verkeerlang_wear'), value = 'verkeerlang_wear'})
          table.insert(elements, {label = _U('ovdpkort_wear'), value = 'ovdpkort_wear'})
          table.insert(elements, {label = _U('ovdplang_wear'), value = 'ovdplang_wear'})
          table.insert(elements, {label = _U('motor_wear'), value = 'motor_wear'})
          table.insert(elements, {label = _U('unmarked_wear'), value = 'unmarked_wear'})
          table.insert(elements, {label = "DSI Outfit", value = 'dsi_wear'})
      elseif grade == 'commisaris' then
          table.insert(elements, {label = _U('kortnh_wear'), value = 'kortnh_wear'})
          table.insert(elements, {label = _U('langnh_wear'), value = 'langnh_wear'})
          table.insert(elements, {label = _U('verkeerkort_wear'), value = 'verkeerkort_wear'})
          table.insert(elements, {label = _U('verkeerlang_wear'), value = 'verkeerlang_wear'})
          table.insert(elements, {label = _U('ovdpkort_wear'), value = 'ovdpkort_wear'})
          table.insert(elements, {label = _U('ovdplang_wear'), value = 'ovdplang_wear'})
          table.insert(elements, {label = _U('motor_wear'), value = 'motor_wear'})
          table.insert(elements, {label = _U('unmarked_wear'), value = 'unmarked_wear'})
          table.insert(elements, {label = "DSI Outfit", value = 'dsi_wear'})
      elseif grade == 'boss' then
          table.insert(elements, {label = _U('kortnh_wear'), value = 'kortnh_wear'})
          table.insert(elements, {label = _U('langnh_wear'), value = 'langnh_wear'})
          table.insert(elements, {label = _U('verkeerkort_wear'), value = 'verkeerkort_wear'})
          table.insert(elements, {label = _U('verkeerlang_wear'), value = 'verkeerlang_wear'})
          table.insert(elements, {label = _U('ovdpkort_wear'), value = 'ovdpkort_wear'})
          table.insert(elements, {label = _U('ovdplang_wear'), value = 'ovdplang_wear'})
          table.insert(elements, {label = _U('motor_wear'), value = 'motor_wear'})
          table.insert(elements, {label = _U('unmarked_wear'), value = 'unmarked_wear'})
          table.insert(elements, {label = "DSI Outfit", value = 'dsi_wear'})
      elseif grade == 'kmar1' then
          table.insert(elements, {label = "KMAR Kort", value = 'kmarkort_wear'})
          table.insert(elements, {label = "KMAR Lang", value = 'kmarlang_wear'})
          table.insert(elements, {label = "KMAR Motor", value = 'kmarmotor_wear'})
          table.insert(elements, {label = "KMAR HRB", value = 'hrb_wear'})
          table.insert(elements, {label = "KMAR BSB", value = 'bsb_wear'})
      elseif grade == 'kmar2' then
          table.insert(elements, {label = "KMAR Kort", value = 'kmarkort_wear'})
          table.insert(elements, {label = "KMAR Lang", value = 'kmarlang_wear'})
          table.insert(elements, {label = "KMAR Motor", value = 'kmarmotor_wear'})
          table.insert(elements, {label = "KMAR HRB", value = 'hrb_wear'})
          table.insert(elements, {label = "KMAR BSB", value = 'bsb_wear'})
      elseif grade == 'kmar3' then
          table.insert(elements, {label = "KMAR Kort", value = 'kmarkort_wear'})
          table.insert(elements, {label = "KMAR Lang", value = 'kmarlang_wear'})
          table.insert(elements, {label = "KMAR Motor", value = 'kmarmotor_wear'})
          table.insert(elements, {label = "KMAR HRB", value = 'hrb_wear'})
          table.insert(elements, {label = "KMAR BSB", value = 'bsb_wear'})
      elseif grade == 'kmar4' then
          table.insert(elements, {label = "KMAR Kort", value = 'kmarkort_wear'})
          table.insert(elements, {label = "KMAR Lang", value = 'kmarlang_wear'})
          table.insert(elements, {label = "KMAR Motor", value = 'kmarmotor_wear'})
          table.insert(elements, {label = "KMAR HRB", value = 'hrb_wear'})
          table.insert(elements, {label = "KMAR BSB", value = 'bsb_wear'})
      elseif grade == 'kmar5' then
          table.insert(elements, {label = "KMAR Kort", value = 'kmarkort_wear'})
          table.insert(elements, {label = "KMAR Lang", value = 'kmarlang_wear'})
          table.insert(elements, {label = "KMAR Motor", value = 'kmarmotor_wear'})
          table.insert(elements, {label = "KMAR HRB", value = 'hrb_wear'})
          table.insert(elements, {label = "KMAR BSB", value = 'bsb_wear'})
      elseif grade == 'kmar6' then
          table.insert(elements, {label = "KMAR Kort", value = 'kmarkort_wear'})
          table.insert(elements, {label = "KMAR Lang", value = 'kmarlang_wear'})
          table.insert(elements, {label = "KMAR Motor", value = 'kmarmotor_wear'})
          table.insert(elements, {label = "KMAR HRB", value = 'hrb_wear'})
          table.insert(elements, {label = "KMAR BSB", value = 'bsb_wear'})
      elseif grade == 'kmar7' then
          table.insert(elements, {label = "KMAR Kort", value = 'kmarkort_wear'})
          table.insert(elements, {label = "KMAR Lang", value = 'kmarlang_wear'})
          table.insert(elements, {label = "KMAR Motor", value = 'kmarmotor_wear'})
          table.insert(elements, {label = "KMAR HRB", value = 'hrb_wear'})
          table.insert(elements, {label = "KMAR BSB", value = 'bsb_wear'})
      elseif grade == 'kmar8' then
          table.insert(elements, {label = "KMAR Kort", value = 'kmarkort_wear'})
          table.insert(elements, {label = "KMAR Lang", value = 'kmarlang_wear'})
          table.insert(elements, {label = "KMAR Motor", value = 'kmarmotor_wear'})
          table.insert(elements, {label = "KMAR HRB", value = 'hrb_wear'})
          table.insert(elements, {label = "KMAR BSB", value = 'bsb_wear'})
      elseif grade == 'kmar9' then
          table.insert(elements, {label = "KMAR Kort", value = 'kmarkort_wear'})
          table.insert(elements, {label = "KMAR Lang", value = 'kmarlang_wear'})
          table.insert(elements, {label = "KMAR Motor", value = 'kmarmotor_wear'})
          table.insert(elements, {label = "KMAR HRB", value = 'hrb_wear'})
          table.insert(elements, {label = "KMAR BSB", value = 'bsb_wear'})
      elseif grade == 'kmar10' then
          table.insert(elements, {label = "KMAR Kort", value = 'kmarkort_wear'})
          table.insert(elements, {label = "KMAR Lang", value = 'kmarlang_wear'})
          table.insert(elements, {label = "KMAR Motor", value = 'kmarmotor_wear'})
          table.insert(elements, {label = "KMAR HRB", value = 'hrb_wear'})
          table.insert(elements, {label = "KMAR BSB", value = 'bsb_wear'})
      elseif grade == 'kmar11' then
          table.insert(elements, {label = "KMAR Kort", value = 'kmarkort_wear'})
          table.insert(elements, {label = "KMAR Lang", value = 'kmarlang_wear'})
          table.insert(elements, {label = "KMAR Motor", value = 'kmarmotor_wear'})
          table.insert(elements, {label = "KMAR HRB", value = 'hrb_wear'})
          table.insert(elements, {label = "KMAR BSB", value = 'bsb_wear'})
      elseif grade == 'kmar12' then
          table.insert(elements, {label = "KMAR Kort", value = 'kmarkort_wear'})
          table.insert(elements, {label = "KMAR Lang", value = 'kmarlang_wear'})
          table.insert(elements, {label = "KMAR Motor", value = 'kmarmotor_wear'})
          table.insert(elements, {label = "KMAR HRB", value = 'hrb_wear'})
          table.insert(elements, {label = "KMAR BSB", value = 'bsb_wear'})
      elseif grade == 'kmar13' then
          table.insert(elements, {label = "KMAR Kort", value = 'kmarkort_wear'})
          table.insert(elements, {label = "KMAR Lang", value = 'kmarlang_wear'})
          table.insert(elements, {label = "KMAR Motor", value = 'kmarmotor_wear'})
          table.insert(elements, {label = "KMAR HRB", value = 'hrb_wear'})
          table.insert(elements, {label = "KMAR BSB", value = 'bsb_wear'})
      elseif grade == 'kmar14' then
          table.insert(elements, {label = "KMAR Kort", value = 'kmarkort_wear'})
          table.insert(elements, {label = "KMAR Lang", value = 'kmarlang_wear'})
          table.insert(elements, {label = "KMAR Motor", value = 'kmarmotor_wear'})
          table.insert(elements, {label = "KMAR HRB", value = 'hrb_wear'})
          table.insert(elements, {label = "KMAR BSB", value = 'bsb_wear'})
      elseif grade == 'kmar15' then
          table.insert(elements, {label = "KMAR Kort", value = 'kmarkort_wear'})
          table.insert(elements, {label = "KMAR Lang", value = 'kmarlang_wear'})
          table.insert(elements, {label = "KMAR Motor", value = 'kmarmotor_wear'})
          table.insert(elements, {label = "KMAR HRB", value = 'hrb_wear'})
          table.insert(elements, {label = "KMAR BSB", value = 'bsb_wear'})
      end
  
      if Config.EnableNonFreemodePeds then
          table.insert(elements, {label = 'Zulu Uniform', value = 'freemode_ped', maleModel = 's_m_y_pilot_01', femaleModel = 's_m_y_pilot_01'})
      end
  
      ESX.UI.Menu.CloseAll()
  
      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
      {
          title    = _U('cloakroom'),
          align    = 'top-right',
          elements = elements
      }, function(data, menu)
  
          cleanPlayer(playerPed)
  
          if data.current.value == 'citizen_wear' then
              
              if Config.EnableNonFreemodePeds then
                  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                      local isMale = skin.sex == 0
  
                      TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                          ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                              TriggerEvent('skinchanger:loadSkin', skin)
                              TriggerEvent('esx:restoreLoadout')
                              TriggerEvent('RemovePDWeps')
                          end)
                      end)
  
                  end)
              else
                  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                      TriggerEvent('skinchanger:loadSkin', skin)
                  end)
              end
  
              if Config.MaxInService ~= -1 then
  
                  ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
                      if isInService then
  
                          playerInService = false
  
                          local notification = {
                              title    = _U('service_anonunce'),
                              subject  = '',
                              msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
                              iconType = 1
                          }
  
                          TriggerServerEvent('esx_service:notifyAllInService', notification, 'police')
  
                          TriggerServerEvent('esx_service:disableService', 'police')
                          TriggerEvent('esx_policejob:updateBlip')
                          ESX.ShowNotification(_U('service_out'))
                      end
                  end, 'police')
              end
  
          end
  
          if Config.MaxInService ~= -1 and data.current.value ~= 'citizen_wear' then
              local serviceOk = 'waiting'
  
              ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
                  if not isInService then
  
                      ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
                          if not canTakeService then
                              ESX.ShowNotification(_U('service_max', inServiceCount, maxInService))
                          else
  
                              serviceOk = true
                              playerInService = true
  
                              local notification = {
                                  title    = _U('service_anonunce'),
                                  subject  = '',
                                  msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
                                  iconType = 1
                              }
      
                              TriggerServerEvent('esx_service:notifyAllInService', notification, 'police')
                              TriggerEvent('esx_policejob:updateBlip')
                              ESX.ShowNotification(_U('service_in'))
                          end
                      end, 'police')
  
                  else
                      serviceOk = true
                  end
              end, 'police')
  
              while type(serviceOk) == 'string' do
                  Citizen.Wait(5)
              end
  
              -- if we couldn't enter service don't let the player get changed
              if not serviceOk then
                  return
              end
          end
  
          if
              data.current.value == 'kmarlang_wear' or
              data.current.value == 'kmarkort_wear' or
              data.current.value == 'kmarmotor_wear' or
              data.current.value == 'hrb_wear' or
              data.current.value == 'bsb_wear' or
              data.current.value == 'kortnh_wear' or
              data.current.value == 'tpe_wear' or
              data.current.value == 'dsi_wear' or
              data.current.value == 'langnh_wear' or
              data.current.value == 'verkeerkort_wear' or
              data.current.value == 'verkeerlang_wear' or
              data.current.value == 'ovdpkort_wear' or
              data.current.value == 'ovdplang_wear' or
              data.current.value == 'motor_wear' or
              data.current.value == 'witpak_wear' or
              data.current.value == 'geelpak_wear' or
              data.current.value == 'officer_wear' or
              data.current.value == 'sergeant_wear' or
              data.current.value == 'intendent_wear' or
              data.current.value == 'lieutenant_wear' or
              data.current.value == 'chef_wear' or
              data.current.value == 'boss_wear' or
              data.current.value == 'bullet_wear' or
              data.current.value == 'pet_wear' or
              data.current.value == 'unmarked_wear' or
              data.current.value == 'gilet_wear'
          then
              if data.current.value == 'bullet_wear' or data.current.value == 'bullet1_wear' or data.current.value == 'gilet_wear' or data.current.value == 'tpe_wear' or data.current.value == 'dsi_wear'then
                  SetPedArmour(playerPed, 100);
              end
              setUniform(data.current.value, playerPed)
          end
  
          if data.current.value == 'freemode_ped' then
              local modelHash = ''
  
              ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                  if skin.sex == 0 then
                      modelHash = GetHashKey(data.current.maleModel)
                  else
                      modelHash = GetHashKey(data.current.femaleModel)
                  end
  
                  ESX.Streaming.RequestModel(modelHash, function()
                      SetPlayerModel(PlayerId(), modelHash)
                      SetModelAsNoLongerNeeded(modelHash)
  
                      if data.current.maleModel == "s_m_m_chemsec_01" then
                          SetPedArmour(playerPed, 100);
                      end
  
                      TriggerEvent('esx:restoreLoadout')
                  end)
              end)
  
          end
  
  
  
      end, function(data, menu)
          menu.close()
  
          CurrentAction     = 'menu_cloakroom'
          CurrentActionMsg  = _U('open_cloackroom')
          CurrentActionData = {}
      end)
  end
  
  function OpenArmoryMenu(station)
  
      if Config.EnableArmoryManagement then
  
          local elements = {
              {label = _U('get_weapon'),     value = 'get_weapon'},
              {label = _U('put_weapon'),     value = 'put_weapon'},
              {label = _U('remove_object'),  value = 'get_stock'},
              {label = _U('deposit_object'), value = 'put_stock'}
          }
  
          if PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'kmar15' then
              table.insert(elements, {label = _U('buy_weapons'), value = 'buy_weapons'})
          end
  
          ESX.UI.Menu.CloseAll()
  
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
          {
              title    = _U('armory'),
              align    = 'top-right',
              elements = elements
          }, function(data, menu)
  
              if data.current.value == 'get_weapon' then
                  OpenGetWeaponMenu()
              elseif data.current.value == 'put_weapon' then
                  OpenPutWeaponMenu()
              elseif data.current.value == 'buy_weapons' then
                  OpenBuyWeaponsMenu(station)
              elseif data.current.value == 'put_stock' then
                  OpenPutStocksMenu()
              elseif data.current.value == 'get_stock' then
                  OpenGetStocksMenu()
              end
  
          end, function(data, menu)
              menu.close()
  
              CurrentAction     = 'menu_armory'
              CurrentActionMsg  = _U('open_armory')
              CurrentActionData = {station = station}
          end)
  
      else
  
          local elements = {
              {label = "======== Spullen vernietigen ========", value = 'niks'},
              {label = _U('put_weapon'),     value = 'put_weapon'},
              {label = _U('deposit_object'), value = 'put_stock'},
              {label = "===============================", value = 'niks'},
          }
  
          for i=1, #Config.PoliceStations[station].AuthorizedWeapons, 1 do
              local weapon = Config.PoliceStations[station].AuthorizedWeapons[i]
              if weapon.name ~= "alarminterface" then
                  table.insert(elements, {label = weapon.label, value = weapon.name, ammo = weapon.ammo})
              else
                  table.insert(elements, {label = "Alarm Interface", value = weapon.name})
              end
          end
  
          ESX.UI.Menu.CloseAll()
  
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
          {
              title    = _U('armory'),
              align    = 'top-right',
              elements = elements
          }, function(data, menu)
              if data.current.value == 'put_weapon' then
                  OpenPutWeaponMenu()
              elseif data.current.value == 'put_stock' then
                  OpenPutStocksMenu()
              elseif data.current.value == 'niks' then
  
              end
              local weapon = data.current.value
              local ammo = data.current.ammo
                  if weapon ~= "alarminterface" then
                      if weapon == "put_weapon" or weapon == "put_stock" or weapon == 'niks' then
                      else
                          TriggerServerEvent('esx_policejob:giveWeapon', weapon, ammo)
                          Citizen.Wait(2000)
                      end
                      if weapon == "WEAPON_PISTOL" then
                          GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
                      end
  
                      if weapon == "WEAPON_COMBATPISTOL" then
                          GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
                      end
  
                      if weapon == "WEAPON_SPECIALCARBINE_MK2" then
                          GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey('COMPONENT_AT_SIGHTS'))
 			  GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey('COMPONENT_AT_MUZZLE_05'))
                      end
  
                      if weapon == "WEAPON_PUMPSHOTGUN" then
                          GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey('COMPONENT_AT_AR_FLSH'))
                      end
  
                      if weapon == "WEAPON_SMG" then
                          GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey('COMPONENT_AT_SCOPE_MACRO_02'))
                          GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey('COMPONENT_AT_AR_FLSH'))
                      end
                       if weapon == "WEAPON_CARBINERIFLE" then
                          GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey('COMPONENT_CARBINERIFLE_CLIP_01'))
                          GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey('COMPONENT_AT_AR_FLSH'))
                          GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'))
                          GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey('COMPONENT_AT_AR_AFGRIP'))
                      end
                       if weapon == "WEAPON_MICROSMG" then
                          GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey('COMPONENT_MICROSMG_CLIP_01'))
                          GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey('COMPONENT_AT_PI_FLSH'))
                          GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey('COMPONENT_AT_SCOPE_MACRO'))
                          GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey('COMPONENT_AT_AR_SUPP_02'))
                      end
                  else
                      TriggerServerEvent('esx_policejob:giveItem', weapon)
                  end
              end, function(data, menu)
              menu.close()
  
              CurrentAction     = 'menu_armory'
              CurrentActionMsg  = _U('open_armory')
              CurrentActionData = {station = station}
          end)
  
      end
  
  end
  
  function OpenVehicleSpawnerMenu(station, partNum)
  
      ESX.UI.Menu.CloseAll()
  
      if not Config.EnableSocietyOwnedVehicles then
          local elements = {}
  
          local sharedVehicles = Config.AuthorizedVehicles.Shared
          for i=1, #sharedVehicles, 1 do
              table.insert(elements, { label = sharedVehicles[i].label, model = sharedVehicles[i].model})
          end
  
          local authorizedVehicles = Config.AuthorizedVehicles[PlayerData.job.grade_name]
        
          for i=1, #authorizedVehicles, 1 do
              table.insert(elements, { label = authorizedVehicles[i].label, model = authorizedVehicles[i].model})
          end
  
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
          {
              title    = _U('vehicle_menu'),
              align    = 'top-right',
              elements = elements
          }, function(data, menu)
              menu.close()
  
              local foundSpawnPoint, spawnPoint = GetAvailableVehicleSpawnPoint(station, partNum)
  
              if foundSpawnPoint then
                  if Config.MaxInService == -1 then
                      ESX.Game.SpawnVehicle(data.current.model, spawnPoint, spawnPoint.heading, function(vehicle)
                          TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                          SetVehicleMaxMods(vehicle)
                          TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', GetVehicleNumberPlateText(vehicle), 100)
                          SetVehicleFuelLevel(vehicle, 100.0)
                      end)
                  else
  
                      ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
  
                          if isInService then
                              ESX.Game.SpawnVehicle(data.current.model, spawnPoint, spawnPoint.heading, function(vehicle)
                                  TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                  SetVehicleMaxMods(vehicle)
                                  TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', GetVehicleNumberPlateText(vehicle), 100)
                                  SetVehicleFuelLevel(vehicle, 100.0)
                              end)
                          else
                              ESX.ShowNotification(_U('service_not'))
                          end
  
                      end, 'police')
                  end
              end
  
          end, function(data, menu)
              menu.close()
  
              CurrentAction     = 'menu_vehicle_spawner'
              CurrentActionMsg  = _U('vehicle_spawner')
              CurrentActionData = {station = station, partNum = partNum}
          end)
  
      end
  end
  
  function GetAvailableVehicleSpawnPoint(station, partNum)
      local spawnPoints = Config.PoliceStations[station].Vehicles[partNum].SpawnPoints
      local found, foundSpawnPoint = false, nil
  
      for i=1, #spawnPoints, 1 do
          if ESX.Game.IsSpawnPointClear(spawnPoints[i], spawnPoints[i].radius) then
              found, foundSpawnPoint = true, spawnPoints[i]
              break
          end
      end
  
      if found then
          return true, foundSpawnPoint
      else
          ESX.ShowNotification(_U('vehicle_blocked'))
          return false
      end
  end
  
  function OpenPoliceActionsMenu()
      ESX.UI.Menu.CloseAll()
  
      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions',
      {
          title    = 'Politie',
          align    = 'top-right',
          elements = {
              {label = _U('citizen_interaction'),	value = 'citizen_interaction'},
              {label = _U('vehicle_interaction'),	value = 'vehicle_interaction'},
              {label = _U('object_spawner'),		value = 'object_spawner'},
              {label = _U('kleding'),				value = 'kleding'},
          }
      }, function(data, menu)
  
          if data.current.value == 'citizen_interaction' then
              local elements = {
                  {label = "Bekijk id",			value = 'identity_card'},
                  {label = "Fouilleer",			value = 'body_search'},
                  {label = "Handboei",		value = 'handcuff'},
                  {label = "Neem het persoon mee",			value = 'drag'},
                  {label = "Zet het persoon in het voertuig",	value = 'put_in_vehicle'},
                  {label = "Haal het persoon uit het voertuig",	value = 'out_the_vehicle'},
                  {label = "Geef een boete",			value = 'fine'},
                  {label = "Beheer onbetaalde facturen",	value = 'unpaid_bills'},
                  {label = "Gevangenis",              value = 'jail_menu'},
                  {label = "Verleen eerste hulp",       value = 'revive'},
                  {label = "Bekijk vinger id",       value = 'pedid'},
              }
          
              if Config.EnableLicenses then
                  table.insert(elements, { label = _U('license_check'), value = 'license' })
              end
          
              ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'citizen_interaction',
              {
                  title    = _U('citizen_interaction'),
                  align    = 'top-right',
                  elements = elements
              }, function(data2, menu2)
                  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                  if closestPlayer ~= -1 and closestDistance <= 3.0 then
                      local action = data2.current.value
  
                      if action == 'identity_card' then
                          OpenIdentityCardMenu(closestPlayer)
                      elseif action == 'body_search' then
                          if Config.EnableJobLogs == true then
                              TriggerServerEvent('esx_joblogs:AddInLog','police' ,'being_searched' ,GetPlayerName(PlayerId()) , GetPlayerName(closestPlayer))
                          end
                          OpenBodySearchMenu(closestPlayer)
                          ESX.UI.Menu.CloseAll()
                          TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), _U('being_searched'))
                      elseif action == 'handcuff' then
                          TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
                      elseif action == 'drag' then
                          TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
                      elseif action == 'put_in_vehicle' then
                          TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
                      elseif action == 'out_the_vehicle' then
                          TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
                      elseif action == 'fine' then
                          OpenFineMenu(closestPlayer)
                      elseif action == 'license' then
                          ShowPlayerLicense(closestPlayer)
                      elseif action == 'unpaid_bills' then
                          OpenUnpaidBillsMenu(closestPlayer)
                      elseif data2.current.value == 'jail_menu' then
                          TriggerEvent("esx-qalle-jail:openJailMenu")
                      elseif data2.current.value == 'pedid' then
                          ESX.ShowNotification("Vinger ID: ~y~".. GetPlayerPed(closestPlayer))
                      elseif action == 'criminalrecords' then
                          TriggerEvent('esx_criminalrecords:open')
                      elseif action == 'revive' then
              local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
              if closestPlayer == -1 or closestDistance > 3.0 then
                ESX.ShowNotification('revive_inprogress')
              else
                local closestPlayerPed = GetPlayerPed(closestPlayer)
                    local health = GetEntityHealth(closestPlayerPed)
  
                      local playerPed = GetPlayerPed(-1)
                      
                      TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                      Citizen.Wait(10000)
                      ClearPedTasks(playerPed)
                      
                      TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
                  end
                      end
  
                  else
                      ESX.ShowNotification(_U('no_players_nearby'))
                  end
              end, function(data2, menu2)
                  menu2.close()
              end)
          elseif data.current.value == 'vehicle_interaction' then
              local elements  = {}
              local playerPed = PlayerPedId()
              local coords    = GetEntityCoords(playerPed)
              local vehicle   = ESX.Game.GetVehicleInDirection()
              
              if DoesEntityExist(vehicle) then
                  table.insert(elements, {label = _U('vehicle_info'),	value = 'vehicle_infos'})
                  table.insert(elements, {label = _U('pick_lock'),	value = 'hijack_vehicle'})
                  table.insert(elements, {label = _U('impound'),		value = 'impound'})
              end
              
              table.insert(elements, {label = _U('search_database'), value = 'search_database'})
  
              ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'vehicle_interaction',
              {
                  title    = _U('vehicle_interaction'),
                  align    = 'top-right',
                  elements = elements
              }, function(data2, menu2)
                  coords  = GetEntityCoords(playerPed)
                  vehicle = ESX.Game.GetVehicleInDirection()
                  action  = data2.current.value
                  
                  if action == 'search_database' then
                      LookupVehicle()
                  elseif DoesEntityExist(vehicle) then
                      local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
                      if action == 'vehicle_infos' then
                          OpenVehicleInfosMenu(vehicleData)
                          
                      elseif action == 'hijack_vehicle' then
                          if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
                              TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
                              Citizen.Wait(20000)
                              ClearPedTasksImmediately(playerPed)
  
                              SetVehicleDoorsLocked(vehicle, 1)
                              SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                              ESX.ShowNotification(_U('vehicle_unlocked'))
                              if Config.EnableJobLogs == true then
                                  TriggerServerEvent('esx_joblogs:AddInLog','police' ,'hijack_vehicle' ,GetPlayerName(PlayerId()))
                              end
                          end
                      elseif action == 'impound' then
                      
                          -- is the script busy?
                          if CurrentTask.Busy then
                              return
                          end
  
                          ESX.ShowHelpNotification(_U('impound_prompt'))
                          
                          TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                          
                          CurrentTask.Busy = true
                          CurrentTask.Task = ESX.SetTimeout(10000, function()
                              ClearPedTasks(playerPed)
                              ImpoundVehicle(vehicle)
                              Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
                              if Config.EnableJobLogs == true then
                                  TriggerServerEvent('esx_joblogs:AddInLog','police' ,'del_vehicle' ,GetPlayerName(PlayerId()))
                              end
                          end)
                          
                          -- keep track of that vehicle!
                          Citizen.CreateThread(function()
                              while CurrentTask.Busy do
                                  Citizen.Wait(1000)
                              
                                  vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
                                  if not DoesEntityExist(vehicle) and CurrentTask.Busy then
                                      ESX.ShowNotification(_U('impound_canceled_moved'))
                                      ESX.ClearTimeout(CurrentTask.Task)
                                      ClearPedTasks(playerPed)
                                      CurrentTask.Busy = false
                                      break
                                  end
                              end
                          end)
                      end
                  else
                      ESX.ShowNotification(_U('no_vehicles_nearby'))
                  end
  
              end, function(data2, menu2)
                  menu2.close()
              end)
          elseif data.current.value == 'kleding' then
              ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'kleding',
              {
                  title		= _U('cloakroom'),
                  align		= 'top-right',
                  elements = {
                      {label = _U('bullet_wear'), value = 'bullet_wear'},
                      {label = _U('gilet_wear'), value = 'gilet_wear'},
                      {label = "Steekvest (geel)", value = 'bullet1_wear'},
                      {label = "Steekvest (zwart)", value = 'bullet2_wear'},
                      {label = "OVD-P Vest", value = 'ovdp_vest'},
                      {label = "AT Vest", value = 'at_vest'},
                      {label = "DSI Vest", value = 'dsi_vest'},
                      {label = "Vest/hesje weghalen", value = 'no_vest'},
                  }
              }, function(data, menu)
                  if data.current.value == 'citizen_wear' then
                      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                          TriggerEvent('skinchanger:loadSkin', skin)
                      end)
                  elseif data.current.value == 'doctor_wear' then
                      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, boss)
                              TriggerEvent('skinchanger:loadClothes', skin, boss.skin_male)
                      end)
                  elseif data.current.value == 'ambulance_wear' then
                      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                          if skin.sex == 0 then
                              TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
                          else
                              TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
                          end
                      end)
                  end
                          if
                          data.current.value == 'recruit_wear' or
                              data.current.value == 'officer_wear' or
                              data.current.value == 'sergeant_wear' or
                              data.current.value == 'intendent_wear' or
                              data.current.value == 'lieutenant_wear' or
                              data.current.value == 'chef_wear' or
                              data.current.value == 'boss_wear'
                          then
                              setUniform(data.current.value, GetPlayerPed(-1))
                          elseif data.current.value == 'bullet_wear' or data.current.value == 'bullet1_wear' or data.current.value == 'bullet2_wear' or data.current.value == 'gilet_wear' or data.current.value == 'ovdp_vest' or data.current.value == 'dsi_vest'  or data.current.value == 'at_vest' then
                              setUniform(data.current.value, GetPlayerPed(-1))
                              SetPedArmour(GetPlayerPed(-1), 100)
                          elseif data.current.value == 'no_vest' then
                              setUniform(data.current.value, GetPlayerPed(-1))
                              SetPedArmour(GetPlayerPed(-1), 0)
                          end
  
  
                  menu.close()
                  CurrentAction		= 'kleding_actions_menu'
                  CurrentActionData	= {}
          end, function(data, menu)
              menu.close()
          end)
          elseif data.current.value == 'object_spawner' then
              ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'citizen_interaction',
              {
                  title    = _U('traffic_interaction'),
                  align    = 'top-right',
                  elements = {
                      {label = _U('cone'),		value = 'prop_roadcone02a'},
                      {label = _U('barrier'),		value = 'prop_mp_barrier_02b'},
                      {label = _U('spikestrips'),	value = 'p_ld_stinger_s'},
                      {label = _U('box'),			value = 'prop_boxpile_07d'},
                      {label = _U('training'),		value = 'gr_prop_gr_target_04b'}
                      {label = _U('cash'),		value = 'hei_prop_cash_crate_half_full'}
                      {label = _U('pion'),		value = 'prop_air_conelight'}
                      {label = _U('afzetting'),		value = 'prop_fnclink_02i'}
                      {label = _U('tent'),		value = 'prop_gazebo_02'}
                  }
              }, function(data2, menu2)
                  local model     = data2.current.value
                  local playerPed = PlayerPedId()
                  local coords    = GetEntityCoords(playerPed)
                  local forward   = GetEntityForwardVector(playerPed)
                  local x, y, z   = table.unpack(coords + forward * 1.0)
  
                  if model == 'prop_roadcone02a' then
                      z = z - 2.0
                  end
  
                  ESX.Game.SpawnObject(model, {
                      x = x,
                      y = y,
                      z = z
                  }, function(obj)
                      SetEntityHeading(obj, GetEntityHeading(playerPed))
                      PlaceObjectOnGroundProperly(obj)
                  end)
  
              end, function(data2, menu2)
                  menu2.close()
              end)
          end
  
      end, function(data, menu)
          menu.close()
      end)
  end
  
  function OpenIdentityCardMenu(player)
  
      ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
  
          local elements    = {}
          local nameLabel   = _U('name', data.name)
          local jobLabel    = nil
          local sexLabel    = nil
          local dobLabel    = nil
          local heightLabel = nil
          local idLabel     = nil
      
          if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
              jobLabel = _U('job', data.job.label .. ' - ' .. data.job.grade_label)
          else
              jobLabel = _U('job', data.job.label)
          end
      
          if Config.EnableESXIdentity then
      
              nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)
      
              if data.sex ~= nil then
                  if string.lower(data.sex) == 'm' then
                      sexLabel = _U('sex', _U('male'))
                  else
                      sexLabel = _U('sex', _U('female'))
                  end
              else
                  sexLabel = _U('sex', _U('unknown'))
              end
      
              if data.dob ~= nil then
                  dobLabel = _U('dob', data.dob)
              else
                  dobLabel = _U('dob', _U('unknown'))
              end
      
              if data.height ~= nil then
                  heightLabel = _U('height', data.height)
              else
                  heightLabel = _U('height', _U('unknown'))
              end
      
              if data.name ~= nil then
                  idLabel = _U('id', data.name)
              else
                  idLabel = _U('id', _U('unknown'))
              end
      
          end
      
          local elements = {
              {label = nameLabel, value = nil},
              {label = jobLabel,  value = nil},
          }
      
          if Config.EnableESXIdentity then
              table.insert(elements, {label = sexLabel, value = nil})
              table.insert(elements, {label = dobLabel, value = nil})
              table.insert(elements, {label = heightLabel, value = nil})
              table.insert(elements, {label = idLabel, value = nil})
          end
      
          if data.drunk ~= nil then
              table.insert(elements, {label = _U('bac', data.drunk), value = nil})
          end
      
          if data.licenses ~= nil then
      
              table.insert(elements, {label = _U('license_label'), value = nil})
      
              for i=1, #data.licenses, 1 do
                  table.insert(elements, {label = data.licenses[i].label, value = nil})
              end
      
          end
      
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
          {
              title    = _U('citizen_interaction'),
              align    = 'top-right',
              elements = elements,
          }, function(data, menu)
      
          end, function(data, menu)
              menu.close()
          end)
      
      end, GetPlayerServerId(player))
  
  end
  
  function OpenBodySearchMenu(player)
      TriggerEvent("esx_inventoryhud:openPlayerInventory", GetPlayerServerId(player), GetPlayerName(player))
  end
  
  function OpenFineMenu(player)
  
      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine',
      {
          title    = _U('fine'),
          align    = 'top-right',
          elements = {
              {label = _U('traffic_offense'), value = 0},
              {label = _U('minor_offense'),   value = 1},
              {label = _U('average_offense'), value = 2},
              {label = _U('major_offense'),   value = 3}
              {label = _U('crimi'),   value = 5}
              {label = _U('Addable'),   value = 6}
          }
      }, function(data, menu)
          OpenFineCategoryMenu(player, data.current.value)
      end, function(data, menu)
          menu.close()
      end)
  
  end
  
  function OpenFineCategoryMenu(player, category)
  
      ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)
  
          local elements = {}
  
          for i=1, #fines, 1 do
              table.insert(elements, {
                  label     = fines[i].label .. ' <span style="color: green;">$' .. fines[i].amount .. '</span>',
                  value     = fines[i].id,
                  amount    = fines[i].amount,
                  fineLabel = fines[i].label
              })
          end
  
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category',
          {
              title    = _U('fine'),
              align    = 'top-right',
              elements = elements,
          }, function(data, menu)
  
              local label  = data.current.fineLabel
              local amount = data.current.amount
  
              menu.close()
  
              if Config.EnablePlayerManagement then
                  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_police', _U('fine_total', label), amount)
              else
                  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), '', _U('fine_total', label), amount)
              end
  
              if Config.EnableJobLogs == true then
                  TriggerServerEvent('esx_joblogs:AddInLog','police' ,'SendFine' ,GetPlayerName(PlayerId()) ,GetPlayerName(player) ,label ,amount)
              end
              
              ESX.SetTimeout(300, function()
                  OpenFineCategoryMenu(player, category)
              end)
  
          end, function(data, menu)
              menu.close()
          end)
  
      end, category)
  
  end
  
  function LookupVehicle()
      ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle',
      {
          title = _U('search_database_title'),
      }, function(data, menu)
          local length = string.len(data.value)
          if data.value == nil or length < 2 or length > 13 then
              ESX.ShowNotification(_U('search_database_error_invalid'))
          else
              ESX.TriggerServerCallback('esx_policejob:getVehicleFromPlate', function(owner, found)
                  if found then
                      ESX.ShowNotification(_U('search_database_found', owner))
                  else
                      ESX.ShowNotification(_U('search_database_error_not_found'))
                  end
              end, data.value)
              menu.close()
          end
      end, function(data, menu)
          menu.close()
      end)
  end
  
  function ShowPlayerLicense(player)
      local elements = {}
      local targetName
      ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
          if data.licenses ~= nil then
              for i=1, #data.licenses, 1 do
                  if data.licenses[i].label ~= nil and data.licenses[i].type ~= nil then
                      table.insert(elements, {label = data.licenses[i].label, value = data.licenses[i].type})
                  end
              end
          end
          
          if Config.EnableESXIdentity then
              targetName = data.firstname .. ' ' .. data.lastname
          else
              targetName = data.name
          end
          
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license',
          {
              title    = _U('license_revoke'),
              align    = 'top-right',
              elements = elements,
          }, function(data, menu)
              ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
              TriggerServerEvent('esx_policejob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))
              
              TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.value)
              
              ESX.SetTimeout(300, function()
                  ShowPlayerLicense(player)
              end)
          end, function(data, menu)
              menu.close()
          end)
  
      end, GetPlayerServerId(player))
  end
  
  function OpenUnpaidBillsMenu(player)
      local elements = {}
  
      ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
          for i=1, #bills, 1 do
              table.insert(elements, {label = bills[i].label .. ' - <span style="color: red;">$' .. bills[i].amount .. '</span>', value = bills[i].id})
          end
  
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
          {
              title    = _U('unpaid_bills'),
              align    = 'top-right',
              elements = elements
          }, function(data, menu)
      
          end, function(data, menu)
              menu.close()
          end)
      end, GetPlayerServerId(player))
  end
  
  function OpenVehicleInfosMenu(vehicleData)
  
      ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
  
          local elements = {}
  
          table.insert(elements, {label = _U('plate', retrivedInfo.plate), value = nil})
  
          if retrivedInfo.owner == nil then
              table.insert(elements, {label = _U('owner_unknown'), value = nil})
          else
              table.insert(elements, {label = _U('owner', retrivedInfo.owner), value = nil})
          end
  
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos',
          {
              title    = _U('vehicle_info'),
              align    = 'top-right',
              elements = elements
          }, nil, function(data, menu)
              menu.close()
          end)
  
      end, vehicleData.plate)
  
  end
  
  function OpenGetWeaponMenu()
  
      ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)
          local elements = {}
  
          for i=1, #weapons, 1 do
              if weapons[i].count > 0 then
                  table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
              end
          end
  
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon',
          {
              title    = _U('get_weapon_menu'),
              align    = 'top-right',
              elements = elements
          }, function(data, menu)
  
              menu.close()
  
              ESX.TriggerServerCallback('esx_policejob:removeArmoryWeapon', function()
                  OpenGetWeaponMenu()
              end, data.current.value)
  
          end, function(data, menu)
              menu.close()
          end)
      end)
  
  end
  
  function OpenPutWeaponMenu()
      local elements   = {}
      local playerPed  = PlayerPedId()
      local weaponList = ESX.GetWeaponList()
  
      for i=1, #weaponList, 1 do
          local weaponHash = GetHashKey(weaponList[i].name)
          if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
              table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
          end
      end
  
      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon',
      {
          title    = _U('put_weapon_menu'),
          align    = 'top-right',
          elements = elements
      }, function(data, menu)
  
          menu.close()
  
          ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
              OpenPutWeaponMenu()
          end, data.current.value, true)
  
      end, function(data, menu)
          menu.close()
      end)
  end
  
  function OpenBuyWeaponsMenu(station)
  
      ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)
  
          local elements = {}
  
          for i=1, #Config.PoliceStations[station].AuthorizedWeapons, 1 do
              local weapon = Config.PoliceStations[station].AuthorizedWeapons[i]
              local count  = 0
  
              for i=1, #weapons, 1 do
                  if weapons[i].name == weapon.name then
                      count = weapons[i].count
                      break
                  end
              end
  
              table.insert(elements, {
                  label = 'x' .. count .. ' ' .. ESX.GetWeaponLabel(weapon.name) .. ' $' .. weapon.price,
                  value = weapon.name,
                  price = weapon.price
              })
          end
  
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons',
          {
              title    = _U('buy_weapon_menu'),
              align    = 'top-right',
              elements = elements,
          }, function(data, menu)
  
              ESX.TriggerServerCallback('esx_policejob:buy', function(hasEnoughMoney)
                  if hasEnoughMoney then
                      ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
                          OpenBuyWeaponsMenu(station)
                      end, data.current.value, false)
                  else
                      ESX.ShowNotification(_U('not_enough_money'))
                  end
              end, data.current.price)
  
          end, function(data, menu)
              menu.close()
          end)
  
      end)
  
  end
  
  function OpenGetStocksMenu()
  
      ESX.TriggerServerCallback('esx_policejob:getStockItems', function(items)
  
  
          local elements = {}
  
          for i=1, #items, 1 do
              table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
          end
  
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
          {
              title    = _U('police_stock'),
              align    = 'top-right',
              elements = elements
          }, function(data, menu)
  
              local itemName = data.current.value
  
              ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                  title = _U('quantity')
              }, function(data2, menu2)
  
                  local count = tonumber(data2.value)
  
                  if count == nil then
                      ESX.ShowNotification(_U('quantity_invalid'))
                  else
                      menu2.close()
                      menu.close()
                      TriggerServerEvent('esx_policejob:getStockItem', itemName, count)
  
                      Citizen.Wait(300)
                      OpenGetStocksMenu()
                  end
  
              end, function(data2, menu2)
                  menu2.close()
              end)
  
          end, function(data, menu)
              menu.close()
          end)
  
      end)
  
  end
  
  function OpenPutStocksMenu()
  
      ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)
  
          local elements = {}
  
          for i=1, #inventory.items, 1 do
              local item = inventory.items[i]
  
              if item.count > 0 then
                  table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
              end
          end
  
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
          {
              title    = _U('inventory'),
              align    = 'top-right',
              elements = elements
          }, function(data, menu)
  
              local itemName = data.current.value
  
              ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                  title = _U('quantity')
              }, function(data2, menu2)
  
                  local count = tonumber(data2.value)
  
                  if count == nil then
                      ESX.ShowNotification(_U('quantity_invalid'))
                  else
                      menu2.close()
                      menu.close()
                      TriggerServerEvent('esx_policejob:putStockItems', itemName, count)
  
                      Citizen.Wait(300)
                      OpenPutStocksMenu()
                  end
  
              end, function(data2, menu2)
                  menu2.close()
              end)
  
          end, function(data, menu)
              menu.close()
          end)
      end)
  
  end
  
  RegisterNetEvent('esx:setJob')
  AddEventHandler('esx:setJob', function(job)
      PlayerData.job = job
      
      Citizen.Wait(5000)
      TriggerServerEvent('esx_policejob:forceBlip')
  end)
  
  RegisterNetEvent('RemovePDWeps')
  AddEventHandler('RemovePDWeps', function()
      local weapon = GetHashKey('WEAPON_STUNGUN')
         local weapon2 = GetHashKey('WEAPON_NIGHTSTICK')
          local weapon3 = GetHashKey('WEAPON_PISTOL')
          local weapon4 = GetHashKey('WEAPON_SMG')
          local weapon5 = GetHashKey('WEAPON_SPECIALCARBINE_MK2')
          local weapon6 = GetHashKey('WEAPON_FIREEXTINGUISHER')
          local weapon7 = GetHashKey('WEAPON_PISTOL')
          local weapon8 = GetHashKey('WEAPON_PUMPSHOTGUN')
          local ped = GetPlayerPed(PlayerId())
          RemoveWeaponFromPed(ped, weapon)
          RemoveWeaponFromPed(ped, weapon2)
          RemoveWeaponFromPed(ped, weapon3)
          RemoveWeaponFromPed(ped, weapon4)
          RemoveWeaponFromPed(ped, weapon5)
          RemoveWeaponFromPed(ped, weapon6)
          RemoveWeaponFromPed(ped, weapon7)
          RemoveWeaponFromPed(ped, weapon8)
  end)
  
  RegisterNetEvent('esx_phone:loaded')
  AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
      local specialContact = {
          name       = _U('phone_police'),
          number     = 'police',
          base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTVGcd/u3cfSXaTLEk2j80TCI8ECI9ABCyoiBqhBVQqVG2ppVKBQqUVgUl5OU7HKqNOHUHU0oHamZZWoGkVS6cWAR2JPJuAQBPy2ISEvLN57+v2u2E33e4k6Ngz85+9d++95/zP9/h/39GpqsqiRYsIGz8QZAq28/8PRfC+4HT4fMXFxeiH+GC54NeCbYLLATLpYe/ECx4VnBTsF0wWhM6lXY8VbBE0Ch4IzLcpfDFD2P1TgrdC7nMCZLRxQ9AkiAkQCn77DcH3BC2COoFRkCSIG2JzLwqiQi0RSmCD4JXbmNKh0+kc/X19tLtc9Ll9sk9ZS1yoU71YIk3xsbEx8QaDEc2ttxmaJSKC1ggSKBK8MKwTFQVXRzs3WzpJGjmZgvxcMpMtWIwqsjztvSrlzjYul56jp+46qSmJmMwR+P3+4aZ8TtCprRkk0DvUW7JjmV6lsqoKW/pU1q9YQOE4Nxkx4ladE7zd8ivuVmJQfXZKW5dx5EwPRw4fxNx2g5SUVLw+33AkzoRaQDP9SkFu6OKqz0uF8yaz7vsOL6ycQVLkcSg/BlWNsjuFoKE1knqDSl5aNnmPLmThrE0UvXqQqvJPyMrMGorEHwQfEha57/3P7mXS684GFjy8kreLppPUuBXfyd/ibeoS2kb0mWPANhJdYjb61AxUvx5PdT3+4y+Tb3mTd19ZSebE+VTXVGNQlHAC7w4VhH8TbA36vKq6ilnzlvPSunHw6Trc7XpZ14AyfgYeyz18crGN1Alz6e3qwNNQSv4dZox1h/BW9+O7eIaEsVv41Y4XeHJDG83Nl4mLTwzGhJYtx0PzNTjOB9KMTlc7Nkcem39YAGU7cbeBKVLMPGMVf296nMd2VbBq1wmizHoqqm/wrS1/Zf0+N19YN2PIu1fcIda4Vk66Zx/rVi+jo9eIX9wZGGcFXUMR6BHUa76/2ezioYcXMtpyAl91DSaTfDxlJbtLprHm2ecpObqPuTPzSNV9yKz4a4zJSuLo71/j8Q17ON69EmXiPIlNMe6FoyzOqWPW/MU03Lw5EFcyKghTrNDh7+/vw545mcJcWbTiGKpRdGPMXbx90sGmDaux6sXk+kimjU+BjnMkx3kYP34cXrFuZ+3nrHi6iDMt92JITcPjk3R3naRwZhpuNSqoD93DKaFVU7j2dhcF8+YzNlpErbIBTVh8toVccbaysPB+4pMcuPw25kwSsau7BIlmHpy3guaOPtISYyi/UkaJM5Lpc5agq5Xkcl6gIHkmqaMn0dtylcjIyPThCNyhaXyfR2W0I1our0v6qBii07ih5rDtGSOxNVdk1y4R2SR8jR/g7hQD9l1jUeY/WLJB5m39AlZN4GZyIQ1fFJNsEgt0duBIc5GRkcZF53mNwIzhXPDgQPoZIkiMkbTxtstDMVnmFA4cOsbz2/aKjSQjev4Mp9ZAg+hIpFhB3EH5Yal16+X+Kq3dGfxkzRY+KauBjBzREvGN0kNCTARu94AejBLMHorAQ7cEQMGs2cXvkWshYLDi6e9l728O8P1XW6hKeB2yv42q18tjj+iFTGoSi+X9jJM9RTxS9E+OHT0krhNiZqlbqraoT7RAU5bBGrEknEBhgJks7KXbLS8qERI0ErVqF/Y4K6NHZfLZB+/wzJvncacvFd91oXO3o/O40MfZKJOKu/rne+mRQByXM4lYreb1tUnkizVVA/0SpfpbWaCNBeEE5gb/UH19NLqEgDF+oNDQWcn41Cj0EXFEWqzkOIyYekslFkThsvMxpIyE2hIc6lXGZ6cPyK7Nnk5OipixRdxgUESAYmhq68VsGgy5CYKCUAJTg0+izApXne3CJFmUTwg4L3FProFxU+6krqmXu3MskkhSD2av41jLdzlnfFrSdCZxyqfMnppN6ZUa7pwt0h3fiK9DCt4IO9e7YqisvI7VYgmNv7mhBKKD/9psNi5dOMv5ZjukjsLdr0ffWsyTi6eSlfcA+dmiVyOXs+/sHNZu3M6PdxzgVO9GmDSHsSNqmTz/R6y6Xxqma4fwaS5Mn85n1ZE0Vl3CHBER3lUNEhiURpPJRFdTOcVnpUJnPIhR7cZXfoH5UYc5+E4RzRH3sfSnl9m2dSMjE+Tz9msse+o5dr7UwcQ5T3HwlWUkNuzG3dKFSTbsNs7m/Y8vExOlC29UWkMJlAxKoRQMR3IC7x85zOn6fHS50+U/2Untx2R1voinu5no+DQmz7yPXmMKZnsu0wrm0Oe3YhOVHdm8A09dBQYhTv4T7C+xUPrZh8Qn2MMr4qcDSRfoirWgKAvtgOpv1JI8Zi77X15G7L+fxeOUOiUFxZiULD5fSlNzNM62W+k1yq5gjajGX/ZHvOIyxd+Fkj+P092rWP/si0Qr7VisMaEWuCiYonXFwbAUTWWPYLV245NITnGkUXnpI9butLJn2y6iba+hlp7C09qBcvoN7FYL9mhxo1/y/LoEXK8Pv6qIC8WbBY/xr9YlPLf9dZT+OqKTUwfmDBm/GOw7ws4FWpuUP2gJEZvKqmocuXPZuWYJMzKuSsH+SNwh3bo0p6hao6HeEqwYEZ2M6aKWd3PwTCy7du/D0F1DsmzE6/WGLr5LsDF4LggnYBacCOboQLHQ3FFfR58SR+HCR1iQH8ukhA5s5o5AYZMwUqOp74nl8xvRHDlRTsnxYpJsUjtsceHt2C8Fm0MPJrphTkZvBc4It9RKLOFx91Pf0Igu0k7W2MmkOewS2QYJUJVWVz9VNbXUVVwkyuAmKTFJayrDo/4Jwe/CT0aGYTrWVYEeUfsgXssMRcpyenraQJa0VX9O3ZU+Ma1fax4xGxUsUVFkOUbcama1hf+7+LmA9juHWshwmwOE1iMmCFYEzg1jtIm1BaxW6wCGGoFdewPfvyE4ertTiv4rHC73B855dwp2a23bbd4tC1hvhOCbX7b4VyUQKhxrtSOaYKngasizvwi0RmOS4O1QZf2yYfiaR+73AvhTQEVf+rpn9/8IMAChKDrDzfsdIQAAAABJRU5ErkJggg=='
      }
  
      TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
  end)
  
  -- don't show dispatches if the player isn't in service
  AddEventHandler('esx_phone:cancelMessage', function(dispatchNumber)
      if type(PlayerData.job.name) == 'string' and PlayerData.job.name == 'police' and PlayerData.job.name == dispatchNumber then
          -- if esx_service is enabled
          if Config.MaxInService ~= -1 and not playerInService then
              CancelEvent()
          end
      end
  end)
  
  RegisterNetEvent('esx_policejob:CuffPlayerAnim')
  AddEventHandler('esx_policejob:CuffPlayerAnim', function()
      LoadAnimationDictionary("mp_arrest_paired")
      TaskPlayAnim(GetPlayerPed(-1), "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, -1, 48, 0, 0, 0, 0)
      if AnimationComplete(GetPlayerPed(-1), "mp_arrest_paired", "cop_p2_back_right", 0.89, 300) then
          ClearPedTasks(GetPlayerPed(-1))
      end
  end)
  
  AddEventHandler('esx_policejob:hasEnteredMarker', function(station, part, partNum)
  
      if part == 'Cloakroom' then
          CurrentAction     = 'menu_cloakroom'
          CurrentActionMsg  = _U('open_cloackroom')
          CurrentActionData = {}
  
      elseif part == 'Armory' then
  
          CurrentAction     = 'menu_armory'
          CurrentActionMsg  = _U('open_armory')
          CurrentActionData = {station = station}
  
      elseif part == 'VehicleSpawner' then
  
          CurrentAction     = 'menu_vehicle_spawner'
          CurrentActionMsg  = _U('vehicle_spawner')
          CurrentActionData = {station = station, partNum = partNum}
  
      elseif part == 'HelicopterSpawner' then
  
          local helicopters = Config.PoliceStations[station].Helicopters
  
          if not IsAnyVehicleNearPoint(helicopters[partNum].SpawnPoint.x, helicopters[partNum].SpawnPoint.y, helicopters[partNum].SpawnPoint.z,  3.0) then
              ESX.Game.SpawnVehicle('polmav', helicopters[partNum].SpawnPoint, helicopters[partNum].Heading, function(vehicle)
                  SetVehicleModKit(vehicle, 0)
                  SetVehicleLivery(vehicle, 0)
                  TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', GetVehicleNumberPlateText(vehicle), 100)
                  SetVehicleFuelLevel(vehicle, 100.0)
              end)
          end
  
      elseif part == 'VehicleDeleter' then
  
          local playerPed = PlayerPedId()
          local coords    = GetEntityCoords(playerPed)
  
          if IsPedInAnyVehicle(playerPed,  false) then
  
              local vehicle = GetVehiclePedIsIn(playerPed, false)
  
              if DoesEntityExist(vehicle) then
                  CurrentAction     = 'delete_vehicle'
                  CurrentActionMsg  = _U('store_vehicle')
                  CurrentActionData = {vehicle = vehicle}
              end
  
          end
  
      elseif part == 'BossActions' then
  
          CurrentAction     = 'menu_boss_actions'
          CurrentActionMsg  = _U('open_bossmenu')
          CurrentActionData = {}
  
      end
  
  end)
  
  AddEventHandler('esx_policejob:hasExitedMarker', function(station, part, partNum)
      ESX.UI.Menu.CloseAll()
      CurrentAction = nil
  end)
  
  AddEventHandler('esx_policejob:hasEnteredEntityZone', function(entity)
      local playerPed = PlayerPedId()
  
      if PlayerData.job ~= nil and PlayerData.job.name == 'police' and IsPedOnFoot(playerPed) then
          CurrentAction     = 'remove_entity'
          CurrentActionMsg  = _U('remove_prop')
          CurrentActionData = {entity = entity}
      end
  
      if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
          local playerPed = PlayerPedId()
          local coords    = GetEntityCoords(playerPed)
  
          if IsPedInAnyVehicle(playerPed, false) then
              local vehicle = GetVehiclePedIsIn(playerPed)
  
              for i=0, 7, 1 do
                  SetVehicleTyreBurst(vehicle, i, true, 1000)
              end
          end
      end
  end)
  
  AddEventHandler('esx_policejob:hasExitedEntityZone', function(entity)
      if CurrentAction == 'remove_entity' then
          CurrentAction = nil
      end
  end)
  
  RegisterNetEvent('esx_policejob:handcuff')
  AddEventHandler('esx_policejob:handcuff', function()
      IsHandcuffed    = not IsHandcuffed
      local playerPed = PlayerPedId()
  
      if IsHandcuffed then
          LoadAnimationDictionary("mp_arrest_paired")
          LoadAnimationDictionary("mp_arresting")
          TaskPlayAnim(GetPlayerPed(-1), "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 32, 0, 0, 0, 0)
          setUniform("cuffs", playerPed)
          Citizen.Wait(5000)
      else
          setUniform("no_cuffs", playerPed)
      end
  
      Citizen.CreateThread(function()
          if IsHandcuffed then
  
              RequestAnimDict('mp_arresting')
              while not HasAnimDictLoaded('mp_arresting') do
                  Citizen.Wait(100)
              end
  
              TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
  
              SetEnableHandcuffs(playerPed, true)
              DisablePlayerFiring(playerPed, true)
              SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
              SetPedCanPlayGestureAnims(playerPed, false)
              FreezeEntityPosition(playerPed, false)
              DisplayRadar(false)
  
              if Config.EnableHandcuffTimer then
  
                  if HandcuffTimer.Active then
                      ESX.ClearTimeout(HandcuffTimer.Task)
                  end
  
                  StartHandcuffTimer()
              end
  
          else
              Citizen.Wait(3000)
              if Config.EnableHandcuffTimer and HandcuffTimer.Active then
                  ESX.ClearTimeout(HandcuffTimer.Task)
              end
  
              ClearPedSecondaryTask(playerPed)
              SetEnableHandcuffs(playerPed, false)
              DisablePlayerFiring(playerPed, false)
              SetPedCanPlayGestureAnims(playerPed, true)
              FreezeEntityPosition(playerPed, false)
              DisplayRadar(true)
          end
      end)
  
  end)
  
  RegisterNetEvent('esx_policejob:unrestrain')
  AddEventHandler('esx_policejob:unrestrain', function()
      Citizen.Wait(2500)
      if IsHandcuffed then
          local playerPed = PlayerPedId()
          IsHandcuffed = false
  
          ClearPedSecondaryTask(playerPed)
          SetEnableHandcuffs(playerPed, false)
          DisablePlayerFiring(playerPed, false)
          SetPedCanPlayGestureAnims(playerPed, true)
          FreezeEntityPosition(playerPed, false)
          DisplayRadar(true)
  
          -- end timer
          if Config.EnableHandcuffTimer and HandcuffTimer.Active then
              ESX.ClearTimeout(HandcuffTimer.Task)
          end
      end
  end)
  
  RegisterNetEvent('esx_policejob:drag')
  AddEventHandler('esx_policejob:drag', function(copID)
      ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(IsDead) 
          if not IsHandcuffed and not IsDead then
              return
          end
  
          DragStatus.IsDragged = not DragStatus.IsDragged
          DragStatus.CopId     = tonumber(copID)
      end)
  end)
  
  Citizen.CreateThread(function()
      local playerPed
      local targetPed
  
      while true do
          Citizen.Wait(1)
      if IsHandcuffed or IsEntityPlayingAnim(PlayerPedId(), "missfinale_c1@", "lying_dead_player0", 3) then
          playerPed = PlayerPedId()
  
          if DragStatus.IsDragged then
              targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))
  
              -- undrag if target is in an vehicle
              if not IsPedSittingInAnyVehicle(targetPed) then
                  AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
              else
                  AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
              end
  
          else
              DetachEntity(playerPed, true, false)
          end
      end
      end
  end)
  
  RegisterNetEvent('esx_policejob:putInVehicle')
  AddEventHandler('esx_policejob:putInVehicle', function()
      local playerPed = PlayerPedId()
      local coords    = GetEntityCoords(playerPed)
  
      if not IsHandcuffed then
          return
      end
  
      if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
          local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
  
          if DoesEntityExist(vehicle) then
              local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
              local freeSeat = nil
  
              for i=maxSeats - 1, 0, -1 do
                  if IsVehicleSeatFree(vehicle, i) then
                      freeSeat = i
                      break
                  end
              end
  
              if freeSeat ~= nil then
                  TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
                  DragStatus.IsDragged = false
              end
          end
      end
  end)
  
  RegisterNetEvent('esx_policejob:OutVehicle')
  AddEventHandler('esx_policejob:OutVehicle', function()
      local playerPed = PlayerPedId()
  
      if not IsPedSittingInAnyVehicle(playerPed) then
          return
      end
  
      local vehicle = GetVehiclePedIsIn(playerPed, false)
      TaskLeaveVehicle(playerPed, vehicle, 16)
  end)
  
  -- Handcuff
  Citizen.CreateThread(function()
      while true do
          Citizen.Wait(1)
          local playerPed = PlayerPedId()
  
          if IsHandcuffed then
              DisableControlAction(0, 24, true) -- Attack
              DisableControlAction(0, 257, true) -- Attack 2
              DisableControlAction(0, 25, true) -- Aim
              DisableControlAction(0, 263, true) -- Melee Attack 1
  
              DisableControlAction(0, Keys['R'], true) -- Reload
              DisableControlAction(0, Keys['SPACE'], true) -- Jump
              DisableControlAction(0, Keys['Q'], true) -- Cover
              DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
              DisableControlAction(0, Keys['F'], true) -- Also 'enter'?
  
              DisableControlAction(0, Keys['F1'], true) -- Disable phone
              DisableControlAction(0, Keys['F2'], true) -- Inventory
              DisableControlAction(0, Keys['F3'], true) -- Animations
              DisableControlAction(0, Keys['F6'], true) -- Job
  
              DisableControlAction(0, Keys['C'], true) -- Disable looking behind
              DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
              DisableControlAction(2, Keys['P'], true) -- Disable pause screen
  
              DisableControlAction(0, 59, true) -- Disable steering in vehicle
              DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
              DisableControlAction(0, 72, true) -- Disable reversing in vehicle
  
              DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth
  
              DisableControlAction(0, 264, true) -- Disable melee
              DisableControlAction(0, 257, true) -- Disable melee
              DisableControlAction(0, 140, true) -- Disable melee
              DisableControlAction(0, 141, true) -- Disable melee
              DisableControlAction(0, 142, true) -- Disable melee
              DisableControlAction(0, 143, true) -- Disable melee
              DisableControlAction(0, 75, true)  -- Disable exit vehicle
              DisableControlAction(27, 75, true) -- Disable exit vehicle
              if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 and IsEntityPlayingAnim(playerPed, "mp_arrest_paired", "crook_p2_back_right", 3) ~= 1 then
                  LoadAnimationDictionary("mp_arresting")
                  TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
              end
          else
              Citizen.Wait(500)
          end
      end
  end)
  
  -- Create blips
  Citizen.CreateThread(function()
  
      for k,v in pairs(Config.PoliceStations) do
          local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)
  
          SetBlipSprite (blip, v.Blip.Sprite)
          SetBlipDisplay(blip, v.Blip.Display)
          SetBlipScale  (blip, v.Blip.Scale)
          SetBlipColour (blip, v.Blip.Colour)
          SetBlipAsShortRange(blip, true)
  
          BeginTextCommandSetBlipName('STRING')
          AddTextComponentString(_U('map_blip'))
          EndTextCommandSetBlipName(blip)
      end
  
  end)
  
  -- Display markers
  Citizen.CreateThread(function()
      while true do
  
          Citizen.Wait(1)
  
          if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
  
              local playerPed = PlayerPedId()
              local coords    = GetEntityCoords(playerPed)
  
              for k,v in pairs(Config.PoliceStations) do
  
                  for i=1, #v.Cloakrooms, 1 do
                      if GetDistanceBetweenCoords(coords, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, true) < Config.DrawDistance then
                          DrawMarker(42, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z + 0.02, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
                      end
                  end
  
                  for i=1, #v.Armories, 1 do
                      if GetDistanceBetweenCoords(coords, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, true) < Config.DrawDistance then
                          DrawMarker(4, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z + 0.02, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
                      end
                  end
  
                  for i=1, #v.Vehicles, 1 do
                      if GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true) < Config.DrawDistance and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                          DrawMarker(36, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, Config.MarkerSize.z, 0, 0, 255, 100, false, true, 2, false, false, false, false)
                      end
                  end
  
                  for i=1, #v.VehicleDeleters, 1 do
                      if GetDistanceBetweenCoords(coords, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, true) < Config.DrawDistance then
                          DrawMarker(36, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z + 0.02, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, 255, 0, 0, 100, false, true, 2, false, false, false, false)
                      end
                  end
  
                  if Config.EnablePlayerManagement and (PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'kmar15') then
                      for i=1, #v.BossActions, 1 do
                          if not v.BossActions[i].disabled and GetDistanceBetweenCoords(coords, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, true) < Config.DrawDistance then
                              DrawMarker(30, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z + 0.02, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
                          end
                      end
                  end
  
              end
  
          else
              Citizen.Wait(500)
          end
  
      end
  end)
  
  -- Enter / Exit marker events
  Citizen.CreateThread(function()
  
      while true do
  
          Citizen.Wait(10)
  
          if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
  
              local playerPed      = PlayerPedId()
              local coords         = GetEntityCoords(playerPed)
              local isInMarker     = false
              local currentStation = nil
              local currentPart    = nil
              local currentPartNum = nil
  
              for k,v in pairs(Config.PoliceStations) do
  
                  for i=1, #v.Cloakrooms, 1 do
                      if GetDistanceBetweenCoords(coords, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, true) < Config.MarkerSize.x then
                          isInMarker     = true
                          currentStation = k
                          currentPart    = 'Cloakroom'
                          currentPartNum = i
                      end
                  end
  
                  for i=1, #v.Armories, 1 do
                      if GetDistanceBetweenCoords(coords, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, true) < Config.MarkerSize.x then
                          isInMarker     = true
                          currentStation = k
                          currentPart    = 'Armory'
                          currentPartNum = i
                      end
                  end
  
                  for i=1, #v.Vehicles, 1 do
                      if GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true) < Config.MarkerSize.x then
                          isInMarker     = true
                          currentStation = k
                          currentPart    = 'VehicleSpawner'
                          currentPartNum = i
                      end
                  end
  
                  for i=1, #v.Helicopters, 1 do
                      if GetDistanceBetweenCoords(coords, v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y, v.Helicopters[i].Spawner.z, true) < Config.MarkerSize.x then
                          isInMarker     = true
                          currentStation = k
                          currentPart    = 'HelicopterSpawner'
                          currentPartNum = i
                      end
                  end
  
                  for i=1, #v.VehicleDeleters, 1 do
                      if GetDistanceBetweenCoords(coords, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, true) < Config.MarkerSize.x then
                          isInMarker     = true
                          currentStation = k
                          currentPart    = 'VehicleDeleter'
                          currentPartNum = i
                      end
                  end
  
                  if Config.EnablePlayerManagement and (PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'kmar15') then
                      for i=1, #v.BossActions, 1 do
                          if GetDistanceBetweenCoords(coords, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, true) < Config.MarkerSize.x then
                              isInMarker     = true
                              currentStation = k
                              currentPart    = 'BossActions'
                              currentPartNum = i
                          end
                      end
                  end
  
              end
  
              local hasExited = false
  
              if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
  
                  if
                      (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
                      (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
                  then
                      TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
                      hasExited = true
                  end
  
                  HasAlreadyEnteredMarker = true
                  LastStation             = currentStation
                  LastPart                = currentPart
                  LastPartNum             = currentPartNum
  
                  TriggerEvent('esx_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
              end
  
              if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
                  HasAlreadyEnteredMarker = false
                  TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
              end
  
          else
              Citizen.Wait(500)
          end
  
      end
  end)
  
  -- Enter / Exit entity zone events
  Citizen.CreateThread(function()
      local trackedEntities = {
          'prop_roadcone02a',
          'prop_mp_barrier_02b',
          'p_ld_stinger_s',
          'prop_boxpile_07d',
          'hei_prop_cash_crate_half_full'
      }
  
      while true do
          Citizen.Wait(500)
  
          local playerPed = PlayerPedId()
          local coords    = GetEntityCoords(playerPed)
  
          local closestDistance = -1
          local closestEntity   = nil
  
          for i=1, #trackedEntities, 1 do
              local object = GetClosestObjectOfType(coords.x, coords.y, coords.z, 3.0, GetHashKey(trackedEntities[i]), false, false, false)
  
              if DoesEntityExist(object) then
                  local objCoords = GetEntityCoords(object)
                  local distance  = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, objCoords.x, objCoords.y, objCoords.z, true)
  
                  if closestDistance == -1 or closestDistance > distance then
                      closestDistance = distance
                      closestEntity   = object
                  end
              end
          end
  
          if closestDistance ~= -1 and closestDistance <= 3.0 then
              if LastEntity ~= closestEntity then
                  TriggerEvent('esx_policejob:hasEnteredEntityZone', closestEntity)
                  LastEntity = closestEntity
              end
          else
              if LastEntity ~= nil then
                  TriggerEvent('esx_policejob:hasExitedEntityZone', LastEntity)
                  LastEntity = nil
              end
          end
      end
  end)
  
  -- Key Controls
  Citizen.CreateThread(function()
      while true do
  
          Citizen.Wait(10)
  
          if CurrentAction ~= nil then
              ESX.ShowHelpNotification(CurrentActionMsg)
  
              if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
  
                  if CurrentAction == 'menu_cloakroom' then
                      OpenCloakroomMenu()
                  elseif CurrentAction == 'menu_armory' then
                      if Config.MaxInService == -1 then
                          OpenArmoryMenu(CurrentActionData.station)
                      elseif playerInService then
                          OpenArmoryMenu(CurrentActionData.station)
                      else
                          ESX.ShowNotification(_U('service_not'))
                      end
                  elseif CurrentAction == 'menu_vehicle_spawner' then
                      OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
                  elseif CurrentAction == 'delete_vehicle' then
                      if Config.EnableSocietyOwnedVehicles then
                          local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
                          TriggerServerEvent('esx_society:putVehicleInGarage', 'police', vehicleProps)
                      end
                      ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
                  elseif CurrentAction == 'menu_boss_actions' then
                      ESX.UI.Menu.CloseAll()
                      TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
                          menu.close()
                          CurrentAction     = 'menu_boss_actions'
                          CurrentActionMsg  = _U('open_bossmenu')
                          CurrentActionData = {}
                      end, { wash = false }) -- disable washing money
                  elseif CurrentAction == 'remove_entity' then
                      DeleteEntity(CurrentActionData.entity)
                  end
                  
                  CurrentAction = nil
              end
          end -- CurrentAction end
          
          if IsControlJustReleased(0, Keys['F6']) and not isDead and PlayerData.job ~= nil and PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
              if Config.MaxInService == -1 then
                  OpenPoliceActionsMenu()
              elseif playerInService then
                  OpenPoliceActionsMenu()
              else
                  ESX.ShowNotification(_U('service_not'))
              end
          end
          
          if IsControlJustReleased(0, Keys['E']) and CurrentTask.Busy then
              ESX.ShowNotification(_U('impound_canceled'))
              ESX.ClearTimeout(CurrentTask.Task)
              ClearPedTasks(PlayerPedId())
              
              CurrentTask.Busy = false
          end
      end
  end)
  
  -- Jail
  
  function JailPlayer(player)
      ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'jail_menu', {
          title = _U('jail_menu_info'),
      }, function (data2, menu)
          local jailTime = tonumber(data2.value)
          if jailTime == nil then
              ESX.ShowNotification('invalid number!')
          else
              TriggerServerEvent('esx_jail:sendToJail', player, jailTime * 60)
              menu.close()
          end
      end, function (data2, menu)
          menu.close()
      end)
  end
  
  -- Create blip for colleagues
  function createBlip(id)
      local ped = GetPlayerPed(id)
      local blip = GetBlipFromEntity(ped)
  
      if not DoesBlipExist(blip) then -- Add blip and create head display on player
          blip = AddBlipForEntity(ped)
          SetBlipSprite(blip, 1)
          ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
          SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
          SetBlipNameToPlayerName(blip, id) -- update blip name
          SetBlipScale(blip, 1.5) -- set scale
          SetBlipColour(blip, 38)
          SetBlipAsShortRange(blip, true)
          
          table.insert(blipsCops, blip) -- add blip to array so we can remove it later
      end
  end
  
  RegisterNetEvent('esx_policejob:updateBlip')
  AddEventHandler('esx_policejob:updateBlip', function()
      
      -- Refresh all blips
      for k, existingBlip in pairs(blipsCops) do
          RemoveBlip(existingBlip)
      end
      
      -- Clean the blip table
      blipsCops = {}
  
      -- Enable blip?
      if Config.MaxInService ~= -1 and not playerInService then
          return
      end
  
      if not Config.EnableJobBlip then
          return
      end
      
      -- Is the player a cop? In that case show all the blips for other cops
      if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
          ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
              for i=1, #players, 1 do
                  if players[i].job.name == 'police' then
                      local id = GetPlayerFromServerId(players[i].source)
                      if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
                          createBlip(id)
                      end
                  end
              end
          end)
      end
  
  end)
  
  AddEventHandler('playerSpawned', function(spawn)
      isDead = false
      TriggerEvent('esx_policejob:unrestrain')
      
      if not hasAlreadyJoined then
          TriggerServerEvent('esx_policejob:spawned')
      end
      hasAlreadyJoined = true
  end)
  
  AddEventHandler('esx:onPlayerDeath', function(data)
      isDead = true
  end)
  
  AddEventHandler('onResourceStop', function(resource)
      if resource == GetCurrentResourceName() then
          TriggerEvent('esx_policejob:unrestrain')
          TriggerEvent('esx_phone:removeSpecialContact', 'police')
  
          if Config.MaxInService ~= -1 then
              TriggerServerEvent('esx_service:disableService', 'police')
          end
  
          if Config.EnableHandcuffTimer and HandcuffTimer.Active then
              ESX.ClearTimeout(HandcuffTimer.Task)
          end
      end
  end)
  
  -- handcuff timer, unrestrain the player after an certain amount of time
  function StartHandcuffTimer()
      if Config.EnableHandcuffTimer and HandcuffTimer.Active then
          ESX.ClearTimeout(HandcuffTimer.Task)
      end
  
      HandcuffTimer.Active = true
  
      HandcuffTimer.Task = ESX.SetTimeout(Config.HandcuffTimer, function()
          ESX.ShowNotification(_U('unrestrained_timer'))
          TriggerEvent('esx_policejob:unrestrain')
          HandcuffTimer.Active = false
      end)
  end
  
  -- TODO
  --   - return to garage if owned
  --   - message owner that his vehicle has been impounded
  function ImpoundVehicle(vehicle)
      --local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
      ESX.Game.DeleteVehicle(vehicle) 
      ESX.ShowNotification(_U('impound_successful'))
      CurrentTask.Busy = false
  end
  
  function IsNearPoliceVehicle()
      local pos = GetEntityCoords(GetPlayerPed(-1),true)
      local veh = ESX.Game.GetClosestVehicle()
      if veh ~= nil and veh ~= 0 then
          local vehpos = GetEntityCoords(veh, false)
          if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 3.3 then
              for _, policeveh in pairs(Config.AuthorizedVehicles.Shared) do
                  if GetEntityModel(veh) == GetHashKey(policeveh.model) then
                      return true
                  end
              end
          end
      end
      return false
  end
  
  function LoadAnimationDictionary(animationD) -- Simple way to load animation dictionaries to save lines.
      while(not HasAnimDictLoaded(animationD)) do
          RequestAnimDict(animationD)
          Citizen.Wait(1)
      end
  end
  
  function AnimationComplete( player, animationD, animationN, time, cycles )
      local animation = true
      local count = 0
      repeat
          if ( GetEntityAnimCurrentTime( player, animationD, animationN ) < time ) then
              Citizen.Wait(0)
          end
          count = count + 1
          animation = IsEntityPlayingAnim(player, animationD, animationN , 3)
      until (not animation or count == cycles)
  
      return true
  end
  