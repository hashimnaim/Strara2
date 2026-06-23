--!strict
--@author: hashim.naim
--@date: 6/23/26 [REWRITTEN]
--[[
    STRARA is a lightweight module loader and requries modules at light-speed.
    It is strictly typed and easy to use for both server-sides and client-sides.

    Thank you for using my module loader!~
]]
const CollectionService = game:GetService("CollectionService")
const LogService = game:GetService("LogService");
const RunService = game:GetService("RunService");

const Strara = {};

const TAG = "Strara";

--@brief Will grab modules and store them into a table in a given path.
--@param Grabs the folder path.
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

--@brief Will grab the tagged modules and store them into a table.
--@tag STRARA
const function getTaggedModules()
    local grabbedModules: {ModuleScript} = {};

    for _, module: any in CollectionService:GetTagged(TAG) do
        if module:IsA("ModuleScript") then
            table.insert(grabbedModules, module);
        end;
    end;

    return grabbedModules;
end;

--@brief It will require the modules that are stored inside of the currentModules table and the taggedModules table.
--@param Needs the folder path due to getAllModules() requring the folder path.
const function requireModules(folder: Folder)
    local currentModules: {ModuleScript} = getAllModules(folder);
    local taggedModules: {ModuleScript} = getTaggedModules();

    for _, module: ModuleScript in currentModules do
        if RunService:IsServer() then
            local startTime = os.clock();
            local deltaTime = os.clock() - startTime;

            task.spawn(function()
                warn(`> [S] requiring: {module.Name}`);
                const success, errorMessage = pcall(function()
                    return require(module)
                end);

                if success then
                    return LogService:Warn(`> [S] {module.Name} has been required, time it took: {string.format("%.4f", deltaTime)}`);
                else
                    return LogService:Warn(`> [S] {module.Name} unsuccessful require. {errorMessage}`);
                end;
            end);
        else
            if RunService:IsClient() then
                local startTime = os.clock();
                local deltaTime = os.clock() - startTime;
                
                task.spawn(function()
                    warn(`> [C] requiring: {module.Name}`);
                    const success, errorMessage = pcall(function()
                        return require(module)
                    end);

                    if success then
                        return LogService:Warn(`> [S] {module.Name} has been required, time it took: {string.format("%.4f", deltaTime)}`);
                    else
                        return LogService:Warn(`> [S] {module.Name} unsuccessful require. {errorMessage}`);
                    end;
                end);
            end;
        end;
    end;

    for _, module: ModuleScript in taggedModules do
        if RunService:IsServer() then
            local startTime = os.clock();
            local deltaTime = os.clock() - startTime;

            task.spawn(function()
                warn(`> [S] requiring: {module.Name}`);
                const success, errorMessage = pcall(function()
                    return require(module)
                end);

                if success then
                    return LogService:Warn(`> [S] {module.Name} has been required, time it took: {string.format("%.4f", deltaTime)}`);
                else
                    return LogService:Warn(`> [S] {module.Name} unsuccessful require. {errorMessage}`);
                end;
            end);
        else
            if RunService:IsClient() then
                local startTime = os.clock();
                local deltaTime = os.clock() - startTime;
                
                task.spawn(function()
                    warn(`> [C] requiring: {module.Name}`);
                    const success, errorMessage = pcall(function()
                        return require(module)
                    end);

                    if success then
                        return LogService:Warn(`> [S] {module.Name} has been required, time it took: {string.format("%.4f", deltaTime)}`);
                    else
                        return LogService:Warn(`> [S] {module.Name} unsuccessful require. {errorMessage}`);
                    end;
                end);
            end;
        end;
    end;
end;

--@brief Loads the strara.
--@param Folder path.
function Strara.load(path: Folder)
    requireModules(path)
end;

return Strara;
