--!strict
--@author: hashim.naim

--[[
    STRARA is a lightweight module loader and requries modules at light-speed.
    It is strictly typed and easy to use for both server-sides and client-sides.

    Thank you for using my module loader!~
]]

const RunService = game:GetService("RunService");

const Strara = {};

const function getAllModules(folder: Folder)
    local grabbedModules: {ModuleScript} = {};

    for _, module: any in folder:GetChildren() do
        if module:IsA("ModuleScript") then
            table.insert(grabbedModules, module);
        end;
    end;

    for _, module: any in folder:GetDescendants() do
        if module:IsA("ModuleScript") then
            table.insert(grabbedModules, module);
        end;
    end;


    return grabbedModules;
end;

const function requireModules(folder: Folder)
    local currentModules: {ModuleScript} = getAllModules(folder);

    for _, module: ModuleScript in currentModules do
        if RunService:IsServer() then
            local startTime = os.clock();
            local deltaTime = os.clock() - startTime;

            warn(`> [S] requiring: {module.Name}`);
            task.spawn(function()
                require(module)
                return warn(`> [S] {module.Name} has been required, time it took: {string.format("%.4f", deltaTime)}`);
            end);
        else
            if RunService:IsClient() then
                local startTime = os.clock();
                local deltaTime = os.clock() - startTime;
                
                warn(`> [C] requiring: {module.Name}`);
                task.spawn(function()
                    require(module)
                    return warn(`> [C] {module.Name} has been required, time it took: {string.format("%.4f", deltaTime)}`);
                end);
            end;
        end;
    end;
end;

function Strara.load(path: Folder)
    requireModules(path)
end;

return Strara;