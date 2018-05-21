function collectFiles(parentdir, destinationdir, pattern)
    %Function collectFiles(parentdir, destinationdir, pattern)
    %
    % Collects files from all the directories below parentdir. Files
    % containing pattern in the filename are transferred to destinationdir.
    
    % TODO: option to delete empty folders
    
    files = dir(parentdir);
    
    for i=1:length(files)
        file = files(i);
        filepath = strcat(parentdir, filesep, file.name);
        if file.isdir
            if ~(strcmp(file.name,'.') || strcmp(file.name,'..'))
                % valid folder
                collectFiles(filepath, destinationdir, pattern)
            end
        else
            % valid non-folder file
            regextest = regexp(file.name, pattern, 'ONCE');
            if ~isempty(regextest)
                movefile(filepath, destinationdir);
            end
        end
    end