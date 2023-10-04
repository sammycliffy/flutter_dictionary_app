class Definitions {
  String? definition;
  List<String>? synonyms;
  List<String>? antonyms;

  Definitions({this.definition, this.synonyms, this.antonyms});

  Definitions.fromJson(Map<String, dynamic> json) {
    definition = json['definition'];
    if (json['synonyms'] != null) {
      synonyms = <String>[];
      json['synonyms'].forEach((v) {
        synonyms!.add((v));
      });
    }
    if (json['antonyms'] != null) {
      antonyms = <String>[];
      json['antonyms'].forEach((v) {
        antonyms!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['definition'] = definition;
    if (synonyms != null) {
      data['synonyms'] = synonyms!.map((v) => v).toList();
    }
    if (antonyms != null) {
      data['antonyms'] = antonyms!.map((v) => v).toList();
    }
    return data;
  }
}

class License {
  String? name;
  String? url;

  License({this.name, this.url});

  License.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

class Meanings {
  String? partOfSpeech;
  List<Definitions>? definitions;
  List<String>? synonyms;
  List<String>? antonyms;

  Meanings({this.partOfSpeech, this.definitions, this.synonyms, this.antonyms});

  Meanings.fromJson(Map<String, dynamic> json) {
    partOfSpeech = json['partOfSpeech'];
    if (json['definitions'] != null) {
      definitions = <Definitions>[];
      json['definitions'].forEach((v) {
        definitions!.add(Definitions.fromJson(v));
      });
    }
    if (json['synonyms'] != null) {
      synonyms = <String>[];
      json['synonyms'].forEach((v) {
        synonyms!.add((v));
      });
    }
    if (json['antonyms'] != null) {
      antonyms = <String>[];
      json['antonyms'].forEach((v) {
        antonyms!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partOfSpeech'] = partOfSpeech;
    if (definitions != null) {
      data['definitions'] = definitions!.map((v) => v.toJson()).toList();
    }
    if (synonyms != null) {
      data['synonyms'] = synonyms!.map((v) => v).toList();
    }
    if (antonyms != null) {
      data['antonyms'] = antonyms!.map((v) => v).toList();
    }
    return data;
  }
}

class Phonetics {
  String? text;
  String? audio;
  String? sourceUrl;
  License? license;

  Phonetics({this.text, this.audio, this.sourceUrl, this.license});

  Phonetics.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    audio = json['audio'];
    sourceUrl = json['sourceUrl'];
    license =
        json['license'] != null ? License.fromJson(json['license']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['audio'] = audio;
    data['sourceUrl'] = sourceUrl;
    if (license != null) {
      data['license'] = license!.toJson();
    }
    return data;
  }
}

class WordModel {
  String? word;
  String? phonetic;
  List<Phonetics>? phonetics;
  List<Meanings>? meanings;
  License? license;
  List<String>? sourceUrls;

  WordModel(
      {this.word,
      this.phonetic,
      this.phonetics,
      this.meanings,
      this.license,
      this.sourceUrls});

  WordModel.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    phonetic = json['phonetic'];
    if (json['phonetics'] != null) {
      phonetics = <Phonetics>[];
      json['phonetics'].forEach((v) {
        phonetics!.add(Phonetics.fromJson(v));
      });
    }
    if (json['meanings'] != null) {
      meanings = <Meanings>[];
      json['meanings'].forEach((v) {
        meanings!.add(Meanings.fromJson(v));
      });
    }
    license =
        json['license'] != null ? License.fromJson(json['license']) : null;
    sourceUrls = json['sourceUrls'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;
    data['phonetic'] = phonetic;
    if (phonetics != null) {
      data['phonetics'] = phonetics!.map((v) => v.toJson()).toList();
    }
    if (meanings != null) {
      data['meanings'] = meanings!.map((v) => v.toJson()).toList();
    }
    if (license != null) {
      data['license'] = license!.toJson();
    }
    data['sourceUrls'] = sourceUrls;
    return data;
  }
}
