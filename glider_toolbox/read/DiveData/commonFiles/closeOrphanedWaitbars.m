% ****************************************************************************************************
%
% ****************************************************************************************************
function closeOrphanedWaitbars()
    wh = findall(0, 'tag', 'TMWWaitbar');
    delete(wh);
end
