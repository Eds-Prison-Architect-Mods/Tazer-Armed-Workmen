function getTime()
    return Game.Time()
end
 
local delay = 1;
local ready = getTime();
 
local LOADED = true;
 
local tazerFired = 0;
 
-- Helper functions
 
function spawn( typ, x, y )
    Object.Spawn( tostring(typ), x, y );
end
 
 -- 'Inherited' methods
 
local timing = 0
 
function Create()
    delay = 1
    ready = getTime()
    LOADED = true
    tazerFired = 0
end
 
function Update(timePassed)
    if not LOADED then Create() end
    timing = timing + timePassed
    if getTime() > ready then
        action(timing);
        ready = ready + delay;
        timing = 0
    end
end
 
-- Own functions
 
function action(timePassed)
    if tazerFired > 0 then tazerFired = tazerFired - timePassed return end
    if not (this.Equipment == "Tazer") then print(this.Equipment) return end
    local prisoners = this.GetNearbyObjects("Prisoner", 3)
    for prisoner, dist in pairs(prisoners) do
        local value = prisoner.Misbehavior
        if value == nil then value = "nil" end
         if prisoner.Misbehavior  ~= nil and prisoner.Misbehavior ~= "None" then
            -- FIRE THE TAZOR
            Object.Sound("_Tools", "Attack_Tazer")
            tazerFired = 60
            if math.random(100) > 60 then return end -- Missed
            prisoner.StatusEffects.tazed = 20
            Object.Sound(prisoner, "_Tools", "HitBy_Tazer")
            print("HIT!")
            return
        end
    end
   
end