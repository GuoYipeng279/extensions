FileNames =
{
	--COMMENTEK: 2008. sept. 4.

	-- COMMON
	"3dLightning.mshd",								--3d villam, [n/refl]
	"alphablend.mshd",								--MAP, alfas cuccokra
	"alphachannel.mshd",							--alfatest mindenhova				?????????????????????
	"alphatest.mshd",								--mint fent, nem cullozva sehogy	?????????????????????
	"black.mshd",									--staticshadowshot-hoz, cMatDiffColort outputol
	"building.mshd",								--mindenhol
	"building_editor.mshd",							--hogy egyszeru legyen a shotolas instancing helyett
	"simplebuilding.mshd",							--simple buildnig
	"simplebuilding_editor.mshd",
	"nightsimplebuilding.mshd",						--same with self-illum
	"nightsimplebuilding_editor.mshd",
	"cloud.mshd",									--regi felhok, [n only]
	"cloud_barany.mshd",							--baranyfelhok, [n only]
	"cloud_new.mshd",								--uj felhok, [n/refl]
	"debugshader.mshd",
	"decal.mshd",
	"dolphin.mshd",									--									?????????????????????
	"error.mshd",
	"flag.mshd",									--zaszlo, mindenhova
	"fogsurface.mshd",								--kodmesh, [n/uw]
	"height.mshd",									--shaticshadowshot-hoz, magassagot ir ki
	"invisible.mshd",								--									?????????????????????
	"lightning.mshd",								--villam, [n only]
	"map_ocean_shadow.mshd",						--MAP(oceanre arnyek lap)
	"map_textured.mshd",							--like textured + MAP(molo,kikoto,epuletek latszodjanak), mindenhova
	"map_texturednonormal_bordergrid.mshd",			--MAP(a mintas keret)
	"map_texturednonormal_ocean.mshd",				--MAP(texturazott oceanlap)
	"mapmodel.mshd",								--MAP(osszes hajo, repulo)
	"mapmodel_glow.mshd",							--									?????????????????????
	"particleaxialsprite_dist.mshd",				--distorsion particle
	"particleaxialsprite_n0s0.mshd",				--sima particle
	"particleaxialsprite_n0s1.mshd",				-- +soft
	"particleaxialsprite_n1s0.mshd",				-- +normal mapped
	"particleaxialsprite_n1s1.mshd",				-- +soft+normal mapped
	"particlefloating.mshd",						-- floating
	"particlefloating_editor.mshd",						-- floating editorhoz
	"rain.mshd",									--eso [n only]
	"shadow_static.shfx",							--staticshadowshot-hoz [map], depth-et ir ki
	"shadow_static_cloud.shfx",
	"skined.mshd",									--maszkalo emberkek [n/shadow only]
	"skybox.mshd",								--hdr skybox [n only]
	"soldier.mshd",									--repcsiben uldogelo katonak (=textured, csak arnyek nelkul)
	"textured.mshd",
	"textured_editor.mshd",
	"texturedalpha.mshd",							--cVisibility szerint fade-el
	"texturedindexed.mshd",							
	"texturedvc.mshd",
	"texturedvc_editor.mshd",
	"texturedvcalphatestnomip.mshd",				--aniso filteres textured pl hidhoz
	"texturedvcindexed.mshd",
	"thunder.mshd",									-- tropic? thund? er? [n only]
	"traceline.mshd",								--[n only]
	"textshader.mshd",
	"waterfall.mshd",								--[n/refl]
	"white.mshd",									--staticshadowshot-hoz
	"white_receiver_ocean.mshd",
	
	-- GUI
	"capture_bar.mshd",								--radar alatt
	"formation_gui.mshd",							--MAP(valami formation kor)
	"guialphamul.mshd",								--MAP(pl reconkorok alapja, zoldes negyszogek)
	"guialphamulborder.mshd",						--MAP(borderzone srafozas)
	"guialphamuldarken.mshd",						--MAP(borderzone darkening)
	"guialphastencildiff.mshd",						--MAP(ocean sotetites)
	"guialphawrite.mshd",							--MAP(stencilbe ir, clear es borderzone)
	"guialphawritediff.mshd",						--MAP(stencilbe ir, de nem mindenhova)
	"guibink.mshd",								
	"guibw.mshd",								
	"guicrosshair.mshd",						
	"guicursor.mshd",						
	"guidefault.mshd",							
	"guidefault_point.mshd",							
	"guidefault_noalpha.mshd",
	"guifade.mshd",								
	"guifont.mshd",								
	"guifontbilinear.mshd",							--teglalapra fade/clippelessel
	"guimodel.mshd",							
	"guimultiply.mshd",							
	"map_cmd_building.mshd",						--MAP(cmd buildingek capture/etc korei)
	"mapzone.mshd",									--MAP(kodbol vezerelheto texturedalpha mapre)
	"minimap_terrain.mshd",							--MAP(forgatos fadeelos pozicionalos radar)
	
	-- OCEAN
	"beam.mshd",									--fenyjatek [only uw]
	"ocean.mshd",									--oceanlap felulrol nezve, vb masolassal
	"ocean_vertexsampler.mshd",						--oceanlap felulrol nezve, vertex texture-a;
	"ocean_simple.mshd",							--oceanlap felulrol nezve
	"ocean_vel_and_depth.mshd",
	"oceancolor.mshd",
	"oceanfoam.mshd",
	"oceanheightmapgen.mshd",
	"oceanheightscale.mshd",
	"oceannormalgen.mshd",
	"oceanshadow.mshd",
	"oceanshadow_vsampler.mshd",
	"oceansplash.mshd",
	"oceanunderwater.mshd",							--oceanlap alulrol nezve, vb masolassal
	"oceanunderwater_vertexsampler.mshd",			--oceanlap felulrol nezve, vertex texture-a;	
	"oceanwavedamp.mshd",
	"shore.mshd",									--vizparti hullamzas
	"waterdrops.mshd",
	"waterparticle.mshd",
	"waterspray.mshd",
	"watertracerdisp.mshd",
	"watertracerskined.mshd",
	"watertracerstatic.mshd",
	
	-- PLANE
	"airplane.mshd",								--									?????????????????????
	"airplaner.mshd",								--krom gepek
	"airplanerindexed.mshd",
	"airplanerp.mshd",								--nem-krom gepek
	"airplanerpindexed.mshd",
	"cockpit.mshd",									--cockpitbelso
	"cockpitwin.mshd",								--cockpitablak kivulrol
	"cockpitwinobjspace.mshd",						--	--||--	belulrol
	"noshadow.mshd",								--									?????????????????????
	"noshadowindexed.mshd",
	"pimpdecal.mshd",
	"planealpha.mshd",								--									?????????????????????
	"rotoralpha.mshd",								--									?????????????????????
	"rotoralphaindexed.mshd",						--									?????????????????????
	
	-- POSTPROCESS
	"blendparticles.mshd",
	"bloom.mshd",
	"blur5x5.mshd",
	"BrightPassFilter.mshd",
	"CalculateAdaptedLum.mshd",
	"cleartargets.mshd",
	"cloudshadow.mshd",
	"displace_bump_to_disp.mshd",
	"displace_damp.mshd",
	"downscale_depth.mshd",
	"downscale2x2.mshd",
	"downscale4x4.mshd",
	"dummy_passtrough.mshd",
	"fakemotionblur.mshd",
	"HDRFinalPass.mshd",
	"HDRFinalPass_DOF.mshd",
	"IntPasstrough_DOF.mshd",
	"passtrough.mshd",
	"passtrough_DOF.mshd",
	"passtrough_DOF_wave.mshd",
	"passtrough_wave.mshd",
	"passtrough_oldfilm.mshd",
	"passtrough_oldfilm_wave.mshd",
	"oldfilm_dust.mshd",
	"pipesight.mshd",
	"ResampleAvgLum.mshd",
	"ResampleAvgLumExp.mshd",
	"SampleAvgLum.mshd",
	
	-- SHIP
	"gun.mshd",										--lovegekre
	"gunindexed.mshd",
	"gunvc.mshd",
	"gunvcindexed.mshd",
	"rope.mshd",									--kotelek
	"ropeindexed.mshd",
	"ship.mshd",									--hajok
	"shipalphatest.mshd",							--korlat
	"shipalphatestindexed.mshd",					--csontozott korlat
	"shipnumber.mshd",								--hajoszamok
	"shipnumberindexed.mshd",								--hajoszamok
	"shipvcindexed.mshd",							--csontozott hajok vertexcolorral
	"shipwindow.mshd",								--csicsas hajoablakok
	"shipwindowindexed.mshd",						--csicsas hajoablakok
	"waterclip.mshd",								--vizkiszorito mesh
	"waterflow.mshd",								--tengeralattjaro feljon effect
	"waterflowdist.mshd",							--tengeralattjaro feljon effect 2
	
	-- TERRAIN
	"airfield.mshd",								--repter unique texturaval + detaillel
	"alphatestnomip.mshd",							--TARAWA MODELLFAK KEDVEERT	?????????????????????
	"bterrain.mshd",								--terrain alapshader
	"bterrain_underwater_test.mshd",				--MAP(terrain render maphez)
	"bterrain2b.mshd",								--terrain tile-ozhato mask-al, ami alapshaderbe megy at
	"bterrain2c.mshd",								-- -||- , de meg unique normal mappel is
	"bush.mshd",									--bokrok
	"bush_lores.mshd",									--bokrok
	"bush_editor.mshd",									--bokrok
	"coral.mshd",									--uw corallok
	"coral_editor.mshd",									--uw corallok
	"foliage.mshd",									--vitorlashajok vitorlaihoz (animalt)
	"foliagenomip.mshd",							--TARAWA MODELLFAK KEDVEERT		?????????????????????
	"instanced.mshd",								--fak
	"seaweed.mshd",									--uw novenyzet
	"seaweed_editor.mshd",									--uw novenyzet
	"terrain_ao.mshd",								--staticshadowshot-hoz
	"tree.mshd",									--fak
}