-- Definitions

local util = ...

-- Script

local staffRoles = {
	"admin",
	"owner",
	"chairman",
	"dev",
	"creator",
	"vice",
	"alt",
	"barista",
	"senior",
	"mod",
	"staff",
	"assistant",
	"trainee",
	"ally",
	"allied",
	"allies",
	"manag",
	"contrib",
	"officer",
	"hold",
	"partner",
	"manage",
	"intern",
	"supervis",
	"coord",
	"exec",
	"cook",
	"chef",
	"cashier",
	"shift",
	"lead",
	"pres",
}

game:GetService("Players").PlayerAdded:Connect(function(player)
    if game.CreatorType == Enum.CreatorType.Group then
        local player_role = string.lower(player:GetRoleInGroup(game.CreatorId))
        local found = false
        for _, v in pairs(staffRoles) do
            if string.find(player_role, v) then
                found = true
            end
        end
        if found then
            util.notif('trollarbail', 'We have detected a potential staff member inside your game', 3)
        end
    elseif player.UserId == game.CreatorId or player:IsFriendsWith(game.CreatorId) then
        util.notif('trollarbail', 'An owner or a friend of the owner has joined your game.', 3)
    end
end)