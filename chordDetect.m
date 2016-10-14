function [chords, strings] = chordDetect(chroma)

allChordTypes = {'maj','m','maj7','m7','5','7','9','sus2','sus4','7sus4','7#9','add9','aug','dim','dim7'};
allRoots = {'A','A#','B','C','C#','D','D#','E','F','F#','G','G#'};

chordTypes = allChordTypes;
roots = allRoots;

chordCount = length(chordTypes) * length(roots);

bitMasks = zeros(12,chordCount);
for i = 1:length(roots)
	for j = 1:length(chordTypes)
		c = Chord(roots{i},chordTypes{j});
		bitMasks(c.notes, ((i-1)*length(chordTypes)) + j ) = 1;
	end
	
		
end
complementaryBitMasks = 1 - bitMasks;

chords = cell(1,size(chroma,2));
strings = cell(1,size(chroma,2));
for i = 1:size(chroma,2)
	C = chroma(:,i);
	Cs = repmat(C,1,chordCount);
	Cs = Cs .^ 2;
	deltas = sqrt(sum(Cs .* complementaryBitMasks)) ./ (12-sum(bitMasks));
	[val ind] = min(deltas);
	chords{i} = Chord(roots{ ceil(ind/length(chordTypes)) } , chordTypes{mod(ind-1,length(chordTypes))+1});
	strings{i} = [ roots{ ceil(ind/length(chordTypes)) } , chordTypes{mod(ind-1,length(chordTypes))+1} ];
end

end