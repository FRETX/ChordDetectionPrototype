function [chords, strings] = chordDetect(chroma)

chordCount = 24;
bitMasks = zeros(12,chordCount);
for i = 1:chordCount
	chordName = chordNames(i);
	noteNames = chordNameToNotes(chordName);
	for j = 1:length(noteNames)
		bitMasks(noteNameToSemitoneNumber(noteNames{j}),i) = 1;
	end
end
complementaryBitMasks = 1 - bitMasks;

chords = zeros(1,size(chroma,2));
strings = cell(1,size(chroma,2));
for i = 1:size(chroma,2)
	C = chroma(:,i);
	Cs = repmat(C,1,chordCount);
	Cs = Cs .^ 2;
	deltas = sqrt(sum(Cs .* complementaryBitMasks)) ./ (12-sum(bitMasks));
	[val ind] = min(deltas);
	chords(i) = ind;
	strings{i} = chordNames(i);
end

end