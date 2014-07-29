function[feat nb dim] = loadFeatures(file,NoDescr)
fid = fopen(file, 'r');
dim = fscanf(fid, '%f',1);
if dim==1 
    dim=0;
end
nb = fscanf(fid, '%d',1);
feat = fscanf(fid, '%f', [NoDescr + dim, inf]);
fclose(fid);
