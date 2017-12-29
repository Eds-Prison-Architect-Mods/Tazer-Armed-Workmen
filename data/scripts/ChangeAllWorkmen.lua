local find = this.GetNearbyObjects
local nearby = 9999999 -- tiles

function Update()

  local Workmenssss = this.GetNearbyObjects("Workman",  9999999);
    for Workman, _ in next, Workmenssss do
        Workman.Equipment = 37;
    end
	this.Delete();
end