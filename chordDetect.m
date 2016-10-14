function chord = chordDetect(chroma,targetChords)
% if(0)
% %% Run over possible combinations of selected root & types
% 
% % allRoots = {'A','A#','B','C','C#','D','D#','E','F','F#','G','G#'};
% % allChordTypes = {'maj','m','maj7','m7','5','7','9','sus2','sus4','7sus4','7#9','add9','aug','dim','dim7'};
% % 
% % roots = allRoots;
% % chordTypes = allChordTypes;
% 
% roots = {'A','B','C','D','E','F','G'};
% chordTypes = {'maj','m','5','7','sus2'};
% 
% chordCount = length(chordTypes) * length(roots);
% 
% bitMasks = zeros(12,chordCount);
% for i = 1:length(roots)
% 	for j = 1:length(chordTypes)
% 		c = Chord(roots{i},chordTypes{j});
% 		bitMasks(c.notes, ((i-1)*length(chordTypes)) + j ) = 1;
% 	end	
% end
% complementaryBitMasks = 1 - bitMasks;
% 
% chords = cell(1,size(chroma,2));
% strings = cell(1,size(chroma,2));
% for i = 1:size(chroma,2)
% 	C = chroma(:,i);
% 	Cs = repmat(C,1,chordCount);
% 	Cs = Cs .^ 2;
% 	deltas = sqrt(sum(Cs .* complementaryBitMasks)) ./ (12-sum(bitMasks));
% 	[val ind] = min(deltas);
% 	chords{i} = Chord(roots{ ceil(ind/length(chordTypes)) } , chordTypes{mod(ind-1,length(chordTypes))+1});
% end
% else
%% Run over a manual selection of chords
% targetChords = {Chord('A','maj'),Chord('C','maj'),Chord('D','maj'),Chord('E','maj'),Chord('F','maj'),Chord('G','maj'),Chord('A','m'),Chord('B','m'),Chord('D','m'),Chord('E','m')};

bitMasks = zeros(12,length(targetChords));
for i = 1:length(targetChords)
	c = targetChords{i};
	bitMasks(c.notes, i ) = 1;
end
complementaryBitMasks = 1 - bitMasks;

chordIndices = zeros(size(chroma,2),1);
for i = 1:size(chroma,2)
	C = chroma(:,i);
	Cs = repmat(C,1,length(targetChords));
	Cs = Cs .^ 2;
	deltas = sqrt(sum(Cs .* complementaryBitMasks)) ./ (12-sum(bitMasks));
	[val ind] = min(deltas);
	chordIndices(i) = ind;
end

chord = targetChords{mode(chordIndices)};

% end
end