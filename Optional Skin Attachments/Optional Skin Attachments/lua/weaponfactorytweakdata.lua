dofile(ModPath .. "lua/setup.lua")

--Be careful when messing with legendary mods in uses_parts, can cause sync issues/cheater tags.
--Put default part in adds for Reinfeld 880, Locomotive 12G, and Bootleg so it is re-added after forbid
local orig_WeaponFactoryTweakData_init = WeaponFactoryTweakData.init
function WeaponFactoryTweakData:init()
	orig_WeaponFactoryTweakData_init(self)
	
	--Change to dummy part to hide
	for i, part_id in ipairs(self.wpn_fps_smg_x_p90.uses_parts) do
		if part_id == "wpn_fps_smg_p90_b_legend" then
			self.wpn_fps_smg_x_p90.uses_parts[i] = "wpn_fps_smg_p90_b_legend_dummy"
		end
	end
	for i, part_id in ipairs(self.wpn_fps_pis_x_judge.uses_parts) do
		if part_id == "wpn_fps_pis_judge_b_legend" then
			self.wpn_fps_pis_x_judge.uses_parts[i] = "wpn_fps_pis_judge_b_legend_dummy"
		elseif part_id == "wpn_fps_pis_judge_g_legend" then
			self.wpn_fps_pis_x_judge.uses_parts[i] = "wpn_fps_pis_judge_g_legend_dummy"
		end
	end
	
	--Big Kahuna / Demon
	--Default body adds default grip
	self.parts.wpn_fps_shot_r870_body_standard.adds = self.parts.wpn_fps_shot_r870_body_standard.adds or {}
	table.insert(self.parts.wpn_fps_shot_r870_body_standard.adds, "wpn_fps_upg_m4_g_standard")
	
	--Reinfeld and Locomotive grips forbid default grip
	for _, part_id in pairs(self.wpn_fps_shot_r870.uses_parts) do
		if self.parts[part_id] and self.parts[part_id].type == "grip" and part_id ~= "wpn_fps_upg_m4_g_standard" then
			self.parts[part_id].forbids = self.parts[part_id].forbids or {}
			if not table.contains(self.parts[part_id].forbids, "wpn_fps_upg_m4_g_standard") then
				table.insert(self.parts[part_id].forbids, "wpn_fps_upg_m4_g_standard")
			end
		end
	end
	for _, part_id in pairs(self.wpn_fps_shot_serbu.uses_parts) do
		if self.parts[part_id] and self.parts[part_id].type == "grip" and part_id ~= "wpn_fps_upg_m4_g_standard" then
			self.parts[part_id].forbids = self.parts[part_id].forbids or {}
			if not table.contains(self.parts[part_id].forbids, "wpn_fps_upg_m4_g_standard") then
				table.insert(self.parts[part_id].forbids, "wpn_fps_upg_m4_g_standard")
			end
		end
	end
	
	--Mars Ultor
	--Default lower receiver adds default barrel extension
	self.parts.wpn_fps_ass_tecci_lower_reciever.adds = self.parts.wpn_fps_ass_tecci_lower_reciever.adds or {}
	table.insert(self.parts.wpn_fps_ass_tecci_lower_reciever.adds, "wpn_fps_ass_tecci_ns_standard")
	
	--Bootleg barrel extensions forbid default barrel extension
	for _, part_id in pairs(self.wpn_fps_ass_tecci.uses_parts) do
		if self.parts[part_id] and self.parts[part_id].type == "barrel_ext" and part_id ~= "wpn_fps_ass_tecci_ns_standard" then
			self.parts[part_id].forbids = self.parts[part_id].forbids or {}
			if not table.contains(self.parts[part_id].forbids, "wpn_fps_ass_tecci_ns_standard") then
				table.insert(self.parts[part_id].forbids, "wpn_fps_ass_tecci_ns_standard")
			end
		end
	end
end

--Set up legendary parts
local orig_WeaponFactoryTweakData__init_legendary = WeaponFactoryTweakData._init_legendary
function WeaponFactoryTweakData:_init_legendary()
	orig_WeaponFactoryTweakData__init_legendary(self)
	
	--Set up dummy parts
	--Set unatainable to nil to prevent false cheater tags since dummy part isn't in default_blueprint.
	--Edge case: someone cheats legendary skin, puts it on akimbo variant -> not detected.
	self.parts.wpn_fps_smg_p90_b_legend_dummy = deep_clone(self.parts.wpn_fps_smg_p90_b_legend)
	self.parts.wpn_fps_smg_p90_b_legend_dummy.unatainable = nil
	
	self.parts.wpn_fps_pis_judge_b_legend_dummy = deep_clone(self.parts.wpn_fps_pis_judge_b_legend)
	self.parts.wpn_fps_pis_judge_b_legend_dummy.unatainable = nil
	
	self.parts.wpn_fps_pis_judge_g_legend_dummy = deep_clone(self.parts.wpn_fps_pis_judge_g_legend)
	self.parts.wpn_fps_pis_judge_g_legend_dummy.unatainable = nil
	
	--Set up legendary parts
	local new_values = {
		pcs = {},--Without this, the part gets flagged as inaccessible
		is_a_unlockable = true,--Set unlockable so it can't be dropped/bought
		is_legendary_part = true,--OSA tracking
		has_description = true--So that we can set custom descriptions
	}
	
	--Set new values, remove stats, set name/description
	for skin, part_list in pairs(OSA._gen_1_mods) do
		for _, part_id in pairs(part_list) do
			for k, v in pairs(new_values) do
				self.parts[part_id][k] = v
			end
			if OSA._settings.osa_remove_stats then
				local val = 0
				if self.parts[part_id].stats then
					val = self.parts[part_id].stats.value or val
				end
				--Don't remove stats on SRAB
				if not _G.SRAB or part_id ~= "wpn_fps_sho_ksg_b_legendary" then
					self.parts[part_id].stats = {value = val}
				end
			end
			self.parts[part_id].name_id = "osa_bm_"..part_id
			self.parts[part_id].desc_id = "osa_bm_req_"..skin
			
			--Set sub_type to "laser" so the color can be changed
			if self.parts[part_id].perks then
				if table.contains(self.parts[part_id].perks, "gadget") then
					self.parts[part_id].sub_type = "laser"
				end
			end
			--Raven's barrel sub_type is "silencer" which is wrong, but that gets overwritten so it's fine
		end
	end
	
	--SRAB localization
	if _G.SRAB then
		self.parts.wpn_fps_sho_ksg_b_legendary.name_id = "osa_bm_wpn_fps_sho_ksg_b_legendary_srab"
	end
	
	--Fix foregrip on Raven Admiral
	--Without this, the foregrip will disappear if you apply the Short Barrel then switch to the Admiral Barrel
	--Use insert so we don't overwrite SRAB's forbids
	self.parts.wpn_fps_sho_ksg_b_legendary.forbids = self.parts.wpn_fps_sho_ksg_b_legendary.forbids or {}
	table.insert(self.parts.wpn_fps_sho_ksg_b_legendary.forbids, "wpn_fps_sho_ksg_fg_short")
	self.parts.wpn_fps_sho_ksg_b_legendary.adds = self.parts.wpn_fps_sho_ksg_b_legendary.adds or {}
	table.insert(self.parts.wpn_fps_sho_ksg_b_legendary.adds, "wpn_fps_sho_ksg_fg_standard")
	
	--Big Kahuna
	--Legendary stock forbids default grip
	self.parts.wpn_fps_shot_r870_s_legendary.forbids = self.parts.wpn_fps_shot_r870_s_legendary.forbids or {}
	table.insert(self.parts.wpn_fps_shot_r870_s_legendary.forbids, "wpn_fps_upg_m4_g_standard")
	
	--Demon
	--Legendary stock forbids default grip
	self.parts.wpn_fps_shot_shorty_s_legendary.forbids = self.parts.wpn_fps_shot_shorty_s_legendary.forbids or {}
	table.insert(self.parts.wpn_fps_shot_shorty_s_legendary.forbids, "wpn_fps_upg_m4_g_standard")
	
	--Mars Ultor
	--Legendary barrel forbids default barrel extension
	self.parts.wpn_fps_ass_tecci_b_legend.forbids = self.parts.wpn_fps_ass_tecci_b_legend.forbids or {}
	table.insert(self.parts.wpn_fps_ass_tecci_b_legend.forbids, "wpn_fps_ass_tecci_ns_standard")
	
	--Astatoz
	--Legendary foregrip type changed to "foregrip" (instead of "gadget")
	self.parts.wpn_fps_ass_m16_fg_legend.type = "foregrip"
	
	--Vlad's Rodina
	--Legendary stock adds default grip
	--Legendary grip forbids default grip
	self.parts.wpn_upg_ak_s_legend.adds = self.parts.wpn_upg_ak_s_legend.adds or {}
	table.insert(self.parts.wpn_upg_ak_s_legend.adds, "wpn_upg_ak_g_standard")
	self.parts.wpn_upg_ak_g_legend.forbids = self.parts.wpn_upg_ak_g_legend.forbids or {}
	table.insert(self.parts.wpn_upg_ak_g_legend.forbids, "wpn_upg_ak_g_standard")
end
