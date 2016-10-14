wavfile = 'A.wav';
[y fs] = wavread(wavfile);
if(size(y,2) == 2)
	y = mean(y,2);
end
targetFs = 11025;
yResampled = resample(y,targetFs,fs);

C = chromagram(yResampled,targetFs);

cfftlen = 8192;
tt = [1:size(C,2)]*cfftlen/4/targetFs*(fs/targetFs);
imagesc(tt,[1:12],20*log10(C+eps));
axis xy
% caxis(max(caxis)+[-60 0])
title('Chromagram')
noteStrings = {'A','A#','B','C','C#','D','D#','E','F','F#','G','G#'};
set(gca,'YTick',1:12);
set(gca,'YTickLabel',noteStrings);


[chords,chordNames] = chordDetect(C);
chords{1}
