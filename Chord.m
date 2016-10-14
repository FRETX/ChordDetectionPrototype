classdef Chord
	
	properties
		root
		type
	end
	
	properties (Dependent = true)
		notes
		noteNames
	end
	
	methods (Hidden = true)
		function n = noteNameToSemitoneNumber(obj)
			name = obj.root;
			newName = name;
			if(length(name) == 2)
				if(strcmp(name(2),'b'))
					switch name(1)
						case 'A'
							newName = 'G#';
						case 'B'
							newName = 'A#';
						case 'D'
							newName = 'C#';
						case 'E'
							newName = 'D#';
						case 'G'
							newName = 'F#';
						otherwise
							error('This should not happen');
					end
				end
			end
			switch newName
				case 'A'
					n = 1;
				case 'A#'
					n = 2;
				case 'B'
					n = 3;
				case 'C'
					n = 4;
				case 'C#'
					n = 5;
				case 'D'
					n = 6;
				case 'D#'
					n = 7;
				case 'E'
					n = 8;
				case 'F'
					n = 9;
				case 'F#'
					n = 10;
				case 'G'
					n = 11;
				case 'G#'
					n = 12;
				otherwise
					n = NaN;
			end
		end
		
		function formula = chordFormula(obj)
			majorIntervals = [2 2 1 2 2 2 1 2 2 1 2 2 2 1];
			semitoneLookup = cumsum([1 majorIntervals]);
			formula = [];
			switch obj.type
				case 'maj'
					template = [1,3,5];
					modification = [0 0 0];
				case 'm'
					template = [1,3,5];
					modification = [0 -1 0];
				case 'maj7'
					template = [1,3,5,7];
					modification = [0 0 0 0];
				case 'm7'
					template = [1,3,5,7];
					modification = [0 -1 0 -1];
				case '5'
					template = [1,5];
					modification = [0 0];
				case '7'
					template = [1,3,5,7];
					modification = [0 0 0 -1];
				case '9'
					template = [1,3,5,7,9];
					modification = [0 0 0 -1 0];
				case 'sus2'
					template = [1,2,5];
					modification = [0 0 0];
				case 'sus4'
					template = [1,4,5];
					modification = [0 0 0];
				case '7sus4'
					template = [1,4,5,7];
					modification = [0 0 0 -1];
				case '7#9'
					template = [1,3,5,7,9];
					modification = [0 0 0 -1 +1];
				case 'add9'
					template = [1,3,5,9]; %verify
					modification = [0 0 0 0];
				case 'aug'
					template = [1,3,5];
					modification = [0 0 +1];
				case 'dim'
					template = [1,3,5];
					modification = [0 -1 -1];
				case 'dim7'
					template = [1,3,5,7];
					modification = [0 -1 -1 -2];
				otherwise
					error('This should not happen')
			end
			formula = semitoneLookup(template);
			formula = formula + modification;
		end
		
		function noteNames = semitoneNumberToNoteName(obj,numbers)
			noteNames = cell(1,length(numbers));
			for i = 1:length(numbers)
				switch numbers(i)
					case 1
						noteNames{i} = 'A';
					case 2
						noteNames{i} = 'A#';
					case 3
						noteNames{i} = 'B';
					case 4
						noteNames{i} = 'C';
					case 5
						noteNames{i} = 'C#';
					case 6
						noteNames{i} = 'D';
					case 7
						noteNames{i} = 'D#';
					case 8
						noteNames{i} = 'E';
					case 9
						noteNames{i} = 'F';
					case 10
						noteNames{i} = 'F#';
					case 11
						noteNames{i} = 'G';
					case 12
						noteNames{i} = 'G#';
					otherwise
						error('This should not happen');
				end
			end
			
			
		end
		
	end
	
	methods
		function obj = Chord(root,type)
			obj.root = root;
			obj.type = type;
		end
		
		function obj = set.root(obj,noteString)
			if(length(noteString) <= 2)
				if(~isempty(strfind('ABCDEFG',noteString(1))))
					obj.root = noteString(1);
					if(length(noteString) == 2)
						if(~isempty(strfind('b#',noteString(2))))
							obj.root = noteString;
						else
							error('Root note must contain a note name (A,B,C,D,E,F,G) and an optional accidental (b,#)');
						end
					end
				else
					error('Root note must contain a note name (A,B,C,D,E,F,G) and an optional accidental (b,#)');
				end
			else
				error('Root note must contain a note name (A,B,C,D,E,F,G) and an optional accidental (b,#)');
			end
		end
		
		function obj = set.type(obj,typeString)
			types = {'maj','m','maj7','m7','5','7','9','sus2','sus4','7sus4','7#9','add9','aug','dim','dim7'};
			typeIndex = find(strcmp(types,typeString));
			if(~isempty(typeIndex))
				obj.type = types{typeIndex};
			else
				display(char(['Chord type must be one of:' types]));
				error('Invalid chord type');
			end
		end
		
		function notes = get.notes(obj)
			rootNumber = obj.noteNameToSemitoneNumber();
			formula = obj.chordFormula();
			notes = formula + rootNumber - 1;
			notes = mod(notes,12);
			notes(notes == 0) = 12;
		end
		
		function noteNames = get.noteNames(obj)
			noteNames = obj.semitoneNumberToNoteName(obj.notes);
		end
		
	end
	
end