function notes = chordNameToNotes(name)
names = {'A','A7','Am','Am7','Amaj7','Bb','B7','Bm','C','C7','Cmaj7','D','D7','Dm','Dm7','Dmaj7','E','E7','Em','Em7','F','Fmaj7','G','G7'};
chordNumber = find(strcmp(names,name));


chordNotes = {
	
{'A'	,'C#'	,'E'	,'G#'},
{'A'	,'C#'	,'E'	,'G'},
{'A'	,'C'	,'E'	},
{'A'	,'C'	,'E'	,'G'},
{'A'	,'C#'	,'E'	,'G#'},
{'Bb'	,'D'	,'F'	,'A'},
{'B'	,'D#'	,'F#'	,'A'},
{'B'	,'D'	,'F#'	},
{'C'	,'D#'	,'G'	},
{'C'	,'E'	,'G'	,'Bb'},
{'C'	,'E'	,'G'	,'B'},
{'D'	,'F#'	,'A'	,'C#'},
{'D'	,'F#'	,'A'	,'C'},
{'D'	,'F'	,'A'	},
{'D'	,'F'	,'A'	,'C'},
{'D'	,'F#'	,'A'	,'C#'},
{'E'	,'G#'	,'B'	,'D#'},
{'E'	,'G#'	,'B'	,'D'},
{'E'	,'G'	,'B'	},
{'E'	,'G'	,'B'	,'D'},
{'F'	,'G#'	,'C'	,'D#'},
{'F'	,'A'	,'C'	,'E'},
{'G'	,'B'	,'D'	,'F#'},
{'G'	,'B'	,'D'	,'F'},
	
};

notes = chordNotes{chordNumber};
end