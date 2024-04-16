class BuildGrid {
  const BuildGrid({required this.key});
  final String key;
  static final Map<String, bool> alphabet = {
    'A': false,
    'B': false,
    'C': false,
    'D': false,
    'E': false,
    'F': false,
    'G': false,
    'H': false,
    'I': false,
    'J': false,
    'K': false,
    'L': false,
    'M': false,
    'N': false,
    'O': false,
    'P': false,
    'Q': false,
    'R': false,
    'S': false,
    'T': false,
    'U': false,
    'V': false,
    'W': false,
    'X': false,
    'Y': false,
    'Z': false,
  };

  String gridAlphabet() {
    String gridAlphabet = '';
    for (int i = 0; i < key.length; i++) {
      if (!BuildGrid.alphabet[key[i]]!) {
        if (key[i] == 'J' || key[i] == 'I') {
          gridAlphabet += 'I';
          BuildGrid.alphabet['J'] = true;
          BuildGrid.alphabet['I'] = true;
          continue;
        }
        gridAlphabet += key[i];
        BuildGrid.alphabet[key[i]] = true;
      }
    }

    BuildGrid.alphabet.forEach(
      (key, value) {
        if (!value) {
          if (key == 'I' || key == 'J') {
            BuildGrid.alphabet['I'] = true;
            BuildGrid.alphabet['J'] = true;
            gridAlphabet += 'I';
            return;
          }
          gridAlphabet += key;
        }
      },
    );
    return gridAlphabet;
  }
}
