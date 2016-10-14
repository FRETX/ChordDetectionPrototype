%%
dataDirRoot = [pwd filesep 'data'];
subDirs = getDirsFromDir(dataDirRoot);
dbChords = {Chord('A','maj'),Chord('A','m'),Chord('B','m'),Chord('C','maj'),Chord('D','maj'),Chord('D','m'),Chord('E','maj'),Chord('E','m'),Chord('F','maj'),Chord('G','maj')};
correctPercentages = zeros(length(subDirs),1);

allRoots = {'A','A#','B','C','C#','D','D#','E','F','F#','G','G#'};
allChordTypes = {'maj','m','maj7','m7','5','7','9','sus2','sus4','7sus4','7#9','add9','aug','dim','dim7'};

allChords = cell(1,length(allRoots)*length(allChordTypes));
for i = 1:length(allRoots)
	for j = 1:length(allChordTypes)
		allChords{((i-1)*length(allChordTypes)) + j} = Chord(allRoots{i},allChordTypes{j});
	end
end

%%
for sd = 1:length(subDirs)
	dataDir = [dataDirRoot filesep subDirs(sd).name];
	wavFiles = getFilesFromDir(dataDir,'wav'); 
	display(['=====Processing folder ' , subDirs(sd).name , ' ====='])
	results = cell(length(wavFiles),1);
	for f = 1:length(wavFiles)
		display(['Processing file ' num2str(f) ' of ' num2str(length(wavFiles))])
		wavfile = [dataDir filesep wavFiles(f).name];
		
		[y fs] = wavread(wavfile);
		if(size(y,2) == 2)
			y = mean(y,2);
		end
		targetFs = 11025;
		yResampled = resample(y,targetFs,fs);
		
		C = chromagram(yResampled,targetFs);
		
		
		%results{f} = chordDetect(C,dbChords);
		results{f} = chordDetect(C,allChords);
		
		
		% 	cfftlen = 8192;
		% 	tt = [1:size(C,2)]*cfftlen/4/targetFs*(fs/targetFs);
		% 	imagesc(tt,[1:12],20*log10(C+eps));
		% 	axis xy
		% 	% caxis(max(caxis)+[-60 0])
		% 	title('Chromagram')
		% 	noteStrings = {'A','A#','B','C','C#','D','D#','E','F','F#','G','G#'};
		% 	set(gca,'YTick',1:12);
		% 	set(gca,'YTickLabel',noteStrings);
	end
	
	c = dbChords{sd};
	correct = zeros(length(results),1);
	for i = 1:length(results)
		correct(i) = isSameChord(results{i},c);
	end
	
	correctPercentages(sd) = sum(correct) / length(correct) * 100;
end


%%


%%

