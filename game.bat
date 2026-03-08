@echo off
setlocal EnableDelayedExpansion
title Knight RPG: The Ultimate Matrix
color 0a

:: ===== INITIAL BUILD =====
set prestige=0
set p_multi=1

:char_select
cls
echo ==========================================================
echo                  KNIGHT RPG: ULTIMATE
echo ==========================================================
if !prestige! GTR 0 echo   *** REBIRTH LEVEL: !prestige! (Stats x!p_multi!) ***
echo.
echo Choose your Destiny:
echo 1) Paladin     (High Armor, Holy Magic)
echo 2) Pyromancer  (Low HP, Devastating Damage)
echo 3) Assassin    (High Dodge, Fast Attacks)
echo 4) Necromancer (Siphons HP, Dark Magic)
echo ==========================================================
set /p class_choice=Select Class: 

set level=1
set xp=0
set /a nextxp=50 * p_multi
set /a gold=150 * p_multi

:: Crafting Mats
set bones=0
set dark_iron=0
set dragon_souls=0

:: Upgrades
set sword_up=0
set armor_up=0
set amulet_up=0
set boots_up=0

:: Pets
set pet_name=None
set pet_dmg=0
set pet_type=0

:: Class Setup
if "%class_choice%"=="1" (set class=Paladin & set maxhp=200 & set maxmana=50)
if "%class_choice%"=="2" (set class=Pyromancer & set maxhp=90 & set maxmana=150)
if "%class_choice%"=="3" (set class=Assassin & set maxhp=120 & set maxmana=80)
if "%class_choice%"=="4" (set class=Necromancer & set maxhp=110 & set maxmana=100)

:: Apply Prestige Multiplier to Base Stats
set /a maxhp=maxhp * p_multi
set /a maxmana=maxmana * p_multi
set hp=!maxhp!
set mana=!maxmana!

set sword=1
set w_name=Wooden Sword
set potions=5

:: ===== MAIN HUB =====
:menu
cls
echo ==========================================================
echo  [!class!] Level: !level! ^| Rebirth: !prestige! ^| Gold: !gold!g
echo  HP: !hp!/!maxhp! ^| Mana: !mana!/!maxmana! ^| XP: !xp!/!nextxp!
echo ==========================================================
echo  Weapon: !w_name! (+!sword_up!)
echo  Pet: !pet_name! (Auto-Damage: !pet_dmg!)
echo  Upgrades: Armor(+!armor_up!) Amulet(+!amulet_up!) Boots(+!boots_up!)
echo  Materials: !bones! Bones ^| !dark_iron! Dark Iron ^| !dragon_souls! Souls
echo ==========================================================
echo  1. Explore Wilds (Grind Mats)   6. Crafting Forge
echo  2. The Endless Tower (Bosses)   7. Pet Sanctuary
echo  3. Kingdom Shop                 8. REBIRTH (Level 50+)
echo  4. Blacksmith (Upgrades)        9. Rest at Inn (Free)
echo  5. Abilities                    0. Save Game
echo ==========================================================
set /p choice=Where to, Hero?: 

if "%choice%"=="1" goto explore
if "%choice%"=="2" goto tower
if "%choice%"=="3" goto shop
if "%choice%"=="4" goto blacksmith
if "%choice%"=="5" goto skills
if "%choice%"=="6" goto craft
if "%choice%"=="7" goto pets
if "%choice%"=="8" goto rebirth
if "%choice%"=="9" goto rest
goto menu

:: ===== REST =====
:rest
cls
echo You rest by the fire...
timeout /t 1 >nul
set hp=!maxhp!
set mana=!maxmana!
echo HP and Mana fully restored!
pause
goto menu

:: ===== PET SANCTUARY =====
:pets
cls
echo ======= MYSTIC PET SANCTUARY =======
echo 1) Buy Dire Wolf (500g)     [+15 Auto-Dmg]
echo 2) Buy Shadow Panther (1500g)[+40 Auto-Dmg]
echo 3) Buy Baby Dragon (4000g)  [+100 Auto-Dmg]
echo 4) Leave
set /p pet_c=Choose: 

if "%pet_c%"=="1" if !gold! GEQ 500 (set /a gold-=500 & set pet_name=Dire Wolf & set pet_dmg=15)
if "%pet_c%"=="2" if !gold! GEQ 1500 (set /a gold-=1500 & set pet_name=Shadow Panther & set pet_dmg=40)
if "%pet_c%"=="3" if !gold! GEQ 4000 (set /a gold-=4000 & set pet_name=Baby Dragon & set pet_dmg=100)
goto menu

:: ===== CRAFTING FORGE =====
:craft
cls
echo ======= ANCIENT CRAFTING FORGE =======
echo 1) Bloodletter (Req: 10 Bones, 5 Dark Iron) [Power: 15]
echo 2) Void Blade  (Req: 20 Dark Iron, 2 Souls) [Power: 30]
echo 3) Infinity Edge(Req: 10 Souls, 50,000g)    [Power: 100]
echo 4) Leave
echo ========================================
set /p c_c=Craft what?: 

if "%c_c%"=="1" if !bones! GEQ 10 if !dark_iron! GEQ 5 (
    set /a bones-=10 & set /a dark_iron-=5
    set sword=15 & set w_name=Bloodletter & echo Crafted Bloodletter! & pause
)
if "%c_c%"=="2" if !dark_iron! GEQ 20 if !dragon_souls! GEQ 2 (
    set /a dark_iron-=20 & set /a dragon_souls-=2
    set sword=30 & set w_name=Void Blade & echo Crafted Void Blade! & pause
)
if "%c_c%"=="3" if !dragon_souls! GEQ 10 if !gold! GEQ 50000 (
    set /a dragon_souls-=10 & set /a gold-=50000
    set sword=100 & set w_name=INFINITY EDGE & echo CRAFTED THE INFINITY EDGE! & pause
)
goto menu

:: ===== BLACKSMITH =====
:blacksmith
cls
set /a sc=!sword_up!*100 + 50
set /a ac=!armor_up!*100 + 50
set /a amc=!amulet_up!*150 + 100
set /a bc=!boots_up!*150 + 100

echo ======= ROYAL BLACKSMITH =======
echo Gold: !gold!
echo 1) Sharpen Weapon (+Dmg)   Cost: !sc!g
echo 2) Reinforce Armor (+HP)   Cost: !ac!g
echo 3) Enchant Amulet (+Mana)  Cost: !amc!g
echo 4) Lighten Boots (+Dodge)  Cost: !bc!g
echo 5) Leave
set /p b_c=Upgrade: 

if "%b_c%"=="1" if !gold! GEQ !sc! (set /a gold-=sc & set /a sword_up+=1)
if "%b_c%"=="2" if !gold! GEQ !ac! (set /a gold-=ac & set /a armor_up+=1 & set /a maxhp+=25 & set hp=!maxhp!)
if "%b_c%"=="3" if !gold! GEQ !amc! (set /a gold-=amc & set /a amulet_up+=1 & set /a maxmana+=20 & set mana=!maxmana!)
if "%b_c%"=="4" if !gold! GEQ !bc! (set /a gold-=bc & set /a boots_up+=1)
goto menu

:: ===== SHOP =====
:shop
cls
echo ======= MERCHANTS TENT =======
echo Gold: !gold!
echo 1) Iron Sword (200g) [Power: 3]
echo 2) Steel Claymore (800g) [Power: 8]
echo 3) Buy 5 Health Potions (100g)
echo 4) Leave
set /p s_c=Buy: 
if "%s_c%"=="1" if !gold! GEQ 200 (set /a gold-=200 & set sword=3 & set w_name=Iron Sword)
if "%s_c%"=="2" if !gold! GEQ 800 (set /a gold-=800 & set sword=8 & set w_name=Steel Claymore)
if "%s_c%"=="3" if !gold! GEQ 100 (set /a gold-=100 & set /a potions+=5)
goto menu

:: ===== EXPLORE (GRINDING) =====
:explore
set enemy=Forest Goblin
set /a enemyhp=30 * p_multi + (level * 10)
set /a enemydmg=5 * p_multi + (level * 2)
set loot_type=bones
goto fightstart

:: ===== TOWER (BOSSES) =====
:tower
set /a t_floor=(level / 5) + 1
echo Entering Tower Floor !t_floor!...
timeout /t 1 >nul
if !t_floor! LSS 3 (
    set enemy=Tower Sentinel
    set /a enemyhp=150 * p_multi + (level * 20)
    set /a enemydmg=15 * p_multi + (level * 5)
    set loot_type=dark_iron
) else (
    set enemy=Apex Dragon
    set /a enemyhp=500 * p_multi + (level * 50)
    set /a enemydmg=35 * p_multi + (level * 10)
    set loot_type=dragon_souls
)
goto fightstart

:: ===== COMBAT ENGINE =====
:fightstart
set /a start_enemyhp=!enemyhp!
:fightloop
cls
echo ==========================================================
echo   ENEMY: !enemy! 
echo   HP: [!enemyhp! / !start_enemyhp!]
echo ==========================================================
echo   YOUR HP: !hp!/!maxhp!  ^|  MANA: !mana!/!maxmana!  ^|  POTIONS: !potions!
echo ==========================================================
echo 1) Attack         3) Use Potion (Heal 50%%)
echo 2) Cast Magic     4) Flee
set /p action=Action: 

if "%action%"=="1" goto attack
if "%action%"=="2" goto magic
if "%action%"=="3" goto heal
if "%action%"=="4" goto menu
goto fightloop

:attack
set /a dmg=5 + (sword * 10) + (sword_up * 5) + (level * 2) + (%random% %% 10)
set /a dmg=dmg * p_multi
set /a enemyhp-=dmg
echo You struck for !dmg! damage!
goto pet_phase

:magic
if !mana! LSS 20 (echo Not enough mana! & timeout /t 1 >nul & goto fightloop)
set /a mana-=20
set /a dmg=20 + (amulet_up * 15) + (level * 5)
set /a dmg=dmg * p_multi
set /a enemyhp-=dmg
echo You blasted the enemy with magic for !dmg! damage!
if "%class%"=="Necromancer" (set /a hp+=dmg/2 & echo Siphoned !dmg/2! HP!)
goto pet_phase

:heal
if !potions! LSS 1 (echo No potions left! & timeout /t 1 >nul & goto fightloop)
set /a potions-=1
set /a heal_amt=maxhp / 2
set /a hp+=heal_amt
if !hp! GTR !maxhp! set hp=!maxhp!
echo Healed for !heal_amt! HP!
goto pet_phase

:pet_phase
if "!pet_name!" NEQ "None" (
    set /a enemyhp-=pet_dmg
    echo !pet_name! attacks for !pet_dmg! damage!
)
if !enemyhp! LEQ 0 goto win

:enemy_turn
:: Dodge Mechanic
set /a dodge_chance=boots_up * 2 + 5
set /a dodge_roll=%random% %% 100
if !dodge_roll! LSS !dodge_chance! (
    echo You dodged the enemy attack!
    pause
    goto fightloop
)

set /a edmg=enemydmg + (%random% %% 5)
set /a hp-=edmg
echo !enemy! hits you for !edmg! damage!
if !hp! LEQ 0 goto gameover
pause
goto fightloop

:: ===== VICTORY =====
:win
set /a r_gold=(20 + (%random% %% 30) + (level * 5)) * p_multi
set /a r_xp=(30 + (%random% %% 20) + (level * 10)) * p_multi

echo.
echo === VICTORY ===
echo Gained !r_gold! Gold and !r_xp! XP!
set /a gold+=r_gold
set /a xp+=r_xp

:: Loot Drops
set /a drop_roll=%random% %% 100
if "!loot_type!"=="bones" if !drop_roll! LSS 50 (set /a bones+=1 & echo Found a Monster Bone!)
if "!loot_type!"=="dark_iron" if !drop_roll! LSS 40 (set /a dark_iron+=1 & echo Found Dark Iron!)
if "!loot_type!"=="dragon_souls" if !drop_roll! LSS 20 (set /a dragon_souls+=1 & echo Found a Dragon Soul!)

if !xp! GEQ !nextxp! (
    set /a level+=1
    set xp=0
    set /a nextxp+=75 * p_multi
    set /a maxhp+=20
    set /a maxmana+=10
    set hp=!maxhp!
    set mana=!maxmana!
    echo *** LEVEL UP! You are now Level !level! ***
)
pause
goto menu

:: ===== REBIRTH =====
:rebirth
cls
if !level! LSS 50 (
    echo You must be Level 50 to Rebirth!
    pause
    goto menu
)
echo !!! WARNING !!!
echo Rebirth will reset your Level, Gold, Gear, and Upgrades.
echo You will keep your Pets, Materials, and gain a permanent stat Multiplier!
set /p rb_c=Type YES to Rebirth: 

if /I "%rb_c%"=="YES" (
    set /a prestige+=1
    set /a p_multi+=1
    set level=1
    set gold=0
    set sword_up=0
    set armor_up=0
    set amulet_up=0
    set boots_up=0
    set sword=1
    set w_name=Wooden Sword
    echo You have been REBORN. The universe expands.
    pause
    goto char_select
)
goto menu

:gameover
cls
echo =====================================
echo              YOU DIED
echo =====================================
echo The realm falls to darkness...
pause
exit
