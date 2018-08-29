function collectFiles(sourcedir, destinationdir, pattern, rmsource)
    %Function collectFiles(sourcedir, destinationdir, pattern, rmsource)
    %
    % Collects files from all the directories below sourcedir. Files
    % containing pattern in the filename are transferred to destinationdir.
    % If rmsource is 1, move file instead of copying.
    
    % TODO: option to delete empty folders
    
    files = dir(sourcedir);
    
    for i=1:length(files)
        file = files(i);
        filepath = strcat(sourcedir, filesep, file.name);
        if file.isdir
            if ~(strcmp(file.name,'.') || strcmp(file.name,'..'))
                % valid folder
                collectFiles(filepath, destinationdir, pattern)
            end
        else
            % valid non-folder file
            regextest = regexp(file.name, pattern, 'ONCE');
            if ~isempty(regextest)
                if rmsource
                    disp(strcat("Moving file:", filepath, " to ", destinationdir));
                    status = movefile(filepath, destinationdir);
                else:
                    disp(strcat("Copying file:", filepath, " to ", destinationdir));
                    status = copyfile(filepath, destinationdir);
                end
                if status == 0
                    disp("Cannot move file.");
                end
            end
        end
    end