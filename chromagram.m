function chroma = chromagram(audio,fs)
frameLength = 8192; %assuming fs = 11025
frameShift = frameLength/4;


frame = zeros(frameLength,1);
chroma = zeros(12,ceil(length(audio)/frameLength));
for i = 1:ceil(length(audio)/frameLength)
	frameBegin = (i-1) * frameShift + 1;
	frameEnd = frameBegin + frameLength - 1;
	if(frameEnd > length(audio))
		frame = [ audio(frameBegin:length(audio)) ; zeros(frameBegin+frameLength-1-length(audio),1)];
	else
		frame = audio(frameBegin:frameEnd);
	end
	
	frame = frame .* hamming(length(frame));
	f = fft(frame,frameLength);
	X = abs(f);
	X = X(1:length(X)/2);
	X = sqrt(X);
	
	A1 = 55; %Hz
	note = @(n) A1*2.^((n)/12);
	
	r = 2;
	C = zeros(12,1);
% 	fScale = (fs/2/length(X));
	for n = 0:11
		for phi = 1:5
			for h = 1:2
				kprime = round(note(n)*phi*h/(fs/frameLength));
				k0 = kprime - (r*h);
				k1 = kprime + (r*h);
% 				plot((1:length(X))*fScale,X);
% 				hold on;
% 				plot(k0*fScale,X(k0),'r*');
% 				plot(k1*fScale,X(k1),'r*');
% 				[a,b] = max(X(k0:k1));
% 				plot((k0+b-1)*fScale,X(k0+b-1),'go');
% 				xlim([k0-10,k1+10]*fScale);
% 				hold off;
				C(n+1) = C(n+1) + (max(X(k0:k1)) / h);
			end
		end
	end
	chroma(:,i) = C;
	
end

% chroma = circshift(chroma,-1);

end