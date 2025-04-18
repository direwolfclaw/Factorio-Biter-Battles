-- science logs tab --

local Tabs = require('comfy_panel.main')
local tables = require('maps.biter_battles_v2.tables')
local Functions = require('maps.biter_battles_v2.functions')
local event = require('utils.event')
local bb_config = require('maps.biter_battles_v2.config')
local food_values = tables.food_values
local food_long_and_short = tables.food_long_and_short
local food_long_to_short = tables.food_long_to_short
local forces_list = tables.forces_list
local science_list = tables.science_list
local evofilter_list = tables.evofilter_list
local food_value_table_version = tables.food_value_table_version

local function initialize_dropdown_users_choice()
    storage.dropdown_users_choice_force = {}
    storage.dropdown_users_choice_science = {}
    storage.dropdown_users_choice_evo_filter = {}
end

local function get_science_text(food_name, food_short_name)
    return table.concat({
        '[img=item/',
        food_name,
        '][color=',
        food_values[food_name].color,
        ']',
        food_short_name,
        '[/color]',
    })
end

---@param player LuaPlayer
---@param element LuaGuiElement
local function add_science_logs(player, element)
    local science_scrollpanel = element.add({
        type = 'scroll-pane',
        name = 'scroll_pane',
        direction = 'vertical',
        horizontal_scroll_policy = 'never',
        vertical_scroll_policy = 'auto',
    })
    science_scrollpanel.style.maximal_height = 530

    if storage.science_logs_category_potion == nil then
        storage.science_logs_category_potion = {}
        for i = 1, #food_long_and_short do
            table.insert(
                storage.science_logs_category_potion,
                get_science_text(food_long_and_short[i].long_name, food_long_and_short[i].short_name)
            )
        end
    end
    if storage.science_logs_total_north == nil then
        storage.science_logs_total_north = { 0 }
        storage.science_logs_total_south = { 0 }
        for _ = 1, #food_long_and_short do
            table.insert(storage.science_logs_total_north, 0)
            table.insert(storage.science_logs_total_south, 0)
        end
    end

    local width_summary_columns = tonumber(94)
    local width_summary_first_column = tonumber(110)
    local column_widths = { width_summary_first_column }
    for i = 1, #food_long_and_short do
        column_widths[#column_widths + 1] = width_summary_columns
    end

    local t_summary = science_scrollpanel.add({
        type = 'table',
        name = 'science_logs_summary_header_table',
        column_count = #column_widths,
    })
    local headersSummary = { '', table.unpack(storage.science_logs_category_potion) }
    for _, w in ipairs(column_widths) do
        local label = t_summary.add({ type = 'label', caption = headersSummary[_] })
        label.style.minimal_width = w
        label.style.maximal_width = w
    end

    local summary_panel_table = science_scrollpanel.add({ type = 'table', column_count = #column_widths })
    local label = summary_panel_table.add({
        type = 'label',
        name = 'science_logs_total_north_header',
        caption = 'Total sent by north',
    })
    label.style.minimal_width = width_summary_first_column
    label.style.maximal_width = width_summary_first_column
    for i = 1, #food_long_and_short do
        local label = summary_panel_table.add({
            type = 'label',
            name = 'science_logs_total_north_' .. i,
            caption = storage.science_logs_total_north[i],
        })
        label.style.minimal_width = width_summary_columns
        label.style.maximal_width = width_summary_columns
    end
    science_scrollpanel.add({ type = 'line' })

    local summary_panel_table2 = science_scrollpanel.add({ type = 'table', column_count = #column_widths })
    local label = summary_panel_table2.add({
        type = 'label',
        name = 'science_logs_total_south_header',
        caption = 'Total sent by south',
    })
    label.style.minimal_width = width_summary_first_column
    label.style.maximal_width = width_summary_first_column
    for i = 1, #food_long_and_short do
        local label = summary_panel_table2.add({
            type = 'label',
            name = 'science_logs_total_south' .. i,
            caption = storage.science_logs_total_south[i],
        })
        label.style.minimal_width = width_summary_columns
        label.style.maximal_width = width_summary_columns
    end
    science_scrollpanel.add({ type = 'line' })

    local summary_panel_table3 = science_scrollpanel.add({ type = 'table', column_count = #column_widths })
    local label = summary_panel_table3.add({
        type = 'label',
        name = 'science_logs_total_passive_feed_header',
        caption = 'Total passive feed',
    })
    label.style.minimal_width = width_summary_first_column
    label.style.maximal_width = width_summary_first_column
    for i = 1, #food_long_and_short do
        local text_passive_feed = '0'
        if storage.total_passive_feed_redpotion ~= nil then
            text_passive_feed = math.round(
                storage.total_passive_feed_redpotion * food_value_table_version[1] / food_value_table_version[i],
                1
            )
        end
        local label = summary_panel_table3.add({
            type = 'label',
            name = 'science_logs_passive_feed' .. i,
            caption = text_passive_feed,
        })
        label.style.minimal_width = width_summary_columns
        label.style.maximal_width = width_summary_columns
    end
    science_scrollpanel.add({ type = 'line' })

    if storage.dropdown_users_choice_force == nil then
        initialize_dropdown_users_choice()
    end
    if storage.dropdown_users_choice_force[player.name] == nil then
        storage.dropdown_users_choice_force[player.name] = 1
    end
    if storage.dropdown_users_choice_science[player.name] == nil then
        storage.dropdown_users_choice_science[player.name] = 1
    end
    if storage.dropdown_users_choice_evo_filter[player.name] == nil then
        storage.dropdown_users_choice_evo_filter[player.name] = 1
    end

    local t_filter = science_scrollpanel.add({ type = 'table', name = 'science_logs_filter_table', column_count = 3 })

    local dropdown_force = t_filter.add({
        name = 'dropdown-force',
        type = 'drop-down',
        items = forces_list,
        selected_index = storage.dropdown_users_choice_force[player.name],
    })
    local dropdown_science = t_filter.add({
        name = 'dropdown-science',
        type = 'drop-down',
        items = science_list,
        selected_index = storage.dropdown_users_choice_science[player.name],
    })
    local dropdown_evofilter = t_filter.add({
        name = 'dropdown-evofilter',
        type = 'drop-down',
        items = evofilter_list,
        selected_index = storage.dropdown_users_choice_evo_filter[player.name],
    })

    local t = science_scrollpanel.add({ type = 'table', name = 'science_logs_header_table', column_count = 4 })
    local column_widths = { tonumber(75), tonumber(310), tonumber(165), tonumber(230) }
    local headers = {
        [1] = 'Time',
        [2] = 'Details',
        [3] = 'Evo jump',
        [4] = 'Threat jump',
    }
    for _, w in ipairs(column_widths) do
        local label = t.add({ type = 'label', caption = headers[_] })
        label.style.minimal_width = w
        label.style.maximal_width = w
        label.style.font = 'default-bold'
        label.style.font_color = { r = 0.98, g = 0.66, b = 0.22 }
        if _ == 1 then
            label.style.horizontal_align = 'center'
        end
    end

    if storage.science_logs_text then
        for i = 1, #storage.science_logs_date, 1 do
            local real_force_name = storage.science_logs_fed_team[i]
            local custom_force_name = Functions.team_name_with_color(real_force_name)
            local easy_food_name = food_long_to_short[storage.science_logs_food_name[i]].short_name

            if
                dropdown_force.selected_index == 1
                or real_force_name:match(dropdown_force.get_item(dropdown_force.selected_index))
            then
                if
                    dropdown_science.selected_index == 1
                    or (dropdown_science.selected_index == 2 and (easy_food_name:match('space') or easy_food_name:match(
                        'utility'
                    ) or easy_food_name:match('production')))
                    or (dropdown_science.selected_index == 3 and (easy_food_name:match('space') or easy_food_name:match(
                        'utility'
                    ) or easy_food_name:match('production') or easy_food_name:match('chemical')))
                    or (dropdown_science.selected_index == 4 and (easy_food_name:match('space') or easy_food_name:match(
                        'utility'
                    ) or easy_food_name:match('production') or easy_food_name:match('chemical') or easy_food_name:match(
                        'military'
                    )))
                    or easy_food_name:match(dropdown_science.get_item(dropdown_science.selected_index))
                then
                    if
                        dropdown_evofilter.selected_index == 1
                        or (dropdown_evofilter.selected_index == 2 and (storage.science_logs_evo_jump_difference[i] > 0))
                        or (dropdown_evofilter.selected_index == 3 and (storage.science_logs_evo_jump_difference[i] >= 10))
                        or (dropdown_evofilter.selected_index == 4 and (storage.science_logs_evo_jump_difference[i] >= 5))
                        or (dropdown_evofilter.selected_index == 5 and (storage.science_logs_evo_jump_difference[i] >= 4))
                        or (dropdown_evofilter.selected_index == 6 and (storage.science_logs_evo_jump_difference[i] >= 3))
                        or (dropdown_evofilter.selected_index == 7 and (storage.science_logs_evo_jump_difference[i] >= 2))
                        or (
                            dropdown_evofilter.selected_index == 8
                            and (storage.science_logs_evo_jump_difference[i] >= 1)
                        )
                    then
                        science_panel_table = science_scrollpanel.add({ type = 'table', column_count = 4 })
                        local label = science_panel_table.add({
                            type = 'label',
                            name = 'science_logs_date' .. i,
                            caption = storage.science_logs_date[i],
                        })
                        label.style.minimal_width = column_widths[1]
                        label.style.maximal_width = column_widths[1]
                        label.style.horizontal_align = 'center'
                        local label = science_panel_table.add({
                            type = 'label',
                            name = 'science_logs_text' .. i,
                            caption = storage.science_logs_text[i] .. custom_force_name,
                        })
                        label.style.minimal_width = column_widths[2]
                        label.style.maximal_width = column_widths[2]
                        local label = science_panel_table.add({
                            type = 'label',
                            name = 'science_logs_evo_jump' .. i,
                            caption = storage.science_logs_evo_jump[i]
                                .. '   [color=200,200,200](+'
                                .. storage.science_logs_evo_jump_difference[i]
                                .. ')[/color]',
                        })
                        label.style.minimal_width = column_widths[3]
                        label.style.maximal_width = column_widths[3]
                        local label = science_panel_table.add({
                            type = 'label',
                            name = 'science_logs_threat' .. i,
                            caption = storage.science_logs_threat[i]
                                .. '   [color=200,200,200](+'
                                .. storage.science_logs_threat_jump_difference[i]
                                .. ')[/color]',
                        })
                        label.style.minimal_width = column_widths[4]
                        label.style.maximal_width = column_widths[4]
                        science_scrollpanel.add({ type = 'line' })
                    end
                end
            end
        end
    end
end

local build_config_gui = function(player)
    local frame_sciencelogs = Tabs.comfy_panel_get_active_frame(player)
    if not frame_sciencelogs then
        return
    end
    frame_sciencelogs.clear()
    add_science_logs(player, frame_sciencelogs)
end

local function on_gui_selection_state_changed(event)
    local player = game.get_player(event.player_index)
    if not event.element.valid then
        return
    end
    local name = event.element.name
    if storage.dropdown_users_choice_force == nil then
        initialize_dropdown_users_choice()
    end
    if name == 'dropdown-force' then
        storage.dropdown_users_choice_force[player.name] = event.element.selected_index
        build_config_gui(player)
    end
    if name == 'dropdown-science' then
        storage.dropdown_users_choice_science[player.name] = event.element.selected_index
        build_config_gui(player)
    end
    if name == 'dropdown-evofilter' then
        storage.dropdown_users_choice_evo_filter[player.name] = event.element.selected_index
        build_config_gui(player)
    end
end

event.add(defines.events.on_gui_selection_state_changed, on_gui_selection_state_changed)

comfy_panel_tabs['MutagenLog'] = { gui = build_config_gui, admin = false }
