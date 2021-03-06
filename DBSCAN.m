function isLog = DBSCAN(centers, eps, minCircles)
    
    n = size(centers, 1);
    % Distance between each pair of found circles
    Dist = pdist2(centers, centers);
    % Boolean check of passing
    done = false(n, 1);
    % Boolean check if indexed circle is a log
    isLog = true(n, 1);
    
    for i = 1:n
        if ~done(i)
            done(i) = true;
            
            Neighbors = FindNeighbors(i);
            
            if numel(Neighbors) < minCircles
                isLog(i) = false;
            else
                k = 1;
                while k <= numel(Neighbors)
                j = Neighbors(k);
            
                if ~done(j)
                    done(j) = true;
                
                    Neighbors2 = FindNeighbors(j);
                
                    % Expand cluster
                    if numel(Neighbors2) >= minCircles
                        Neighbors = [Neighbors, Neighbors2];
                    end
                end
            
                k = k + 1;
                end
            end
        end
    end
    
    
    function Neighbors = FindNeighbors(i)
        Neighbors = find(Dist(i, :) <= eps);
    end
end