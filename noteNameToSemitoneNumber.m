function n = noteNameToSemitoneNumber(name)

switch name
	case 'A'
		n = 1;
	case 'Bb'
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