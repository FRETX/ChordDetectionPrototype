function tf = isSameChord(chord1,chord2)

if(strcmp(chord1.root,chord2.root) && strcmp(chord1.type,chord2.type))
	tf = 1;
else
	tf = 0;
end

end