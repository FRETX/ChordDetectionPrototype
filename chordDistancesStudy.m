a = zeros(10,12);
for i = 1:length(dbChords)
    a(i,dbChords{i}.notes) = 1;
end
imagesc(a)

names = cell(1,10);
for i = 1:length(dbChords)
    names{i} = [dbChords{i}.root , dbChords{i}.type];
end
set(gca,'YTickLabels',names)

distanceMatrix = zeros(length(dbChords),length(dbChords));

for i = 1:length(dbChords)
    refChord = zeros(1,12);
    refChord(dbChords{i}.notes) = 1;
    for j = 1:length(dbChords)
        targetChord = zeros(1,12);
        targetChord(dbChords{j}.notes) = 1;
        distanceMatrix(i,j) = sum(abs(refChord - targetChord));
    end
end

imagesc(distanceMatrix)
set(gca,'YTickLabels',names)
set(gca,'XTickLabels',names)
