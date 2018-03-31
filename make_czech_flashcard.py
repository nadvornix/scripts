#!/usr/bin/env python3
"""
dependecies:
- anki (je v virtualenv ankifier)

"""
import json
import sys
import os
import base64
import tempfile
from gtts import gTTS
from anki import Collection

deck_name = "Cz-spelling"
ankiweb_username = "nadvornik.jiri@gmail.com"
PROFILES_PATH = "/home/jiri/ankifier_profiles/{ankiweb_username_base32}"
script_path = os.path.dirname(os.path.realpath(__file__))
mp3_path = script_path + "/audiofiles/"

#####
base_path = PROFILES_PATH.format(
    ankiweb_username_base32=base64.b32encode(
        bytes(ankiweb_username, encoding="utf-8")).decode("ascii"))

if not os.path.exists(base_path):
    os.makedirs(base_path)
collection = Collection(base_path + "/collection.anki2", log=True)

if not os.path.exists(mp3_path):
    os.makedirs(mp3_path)

lines = sys.stdin.readlines()
for word in lines:
    word = word.strip()

    tts = gTTS(text=word, lang='cs')
    deckId = collection.decks.id(deck_name)
    collection.decks.select(deckId)
    basic_model = collection.models.byName('Text-input2')
    if not basic_model:
        print("model text-input does not exist")

        basic_model = json.load(open(script_path + "/Text-input-card.json"))
        collection.models.add(basic_model)

    # basic_model = collection.models.byName('Basic')
    basic_model['did'] = deckId
    collection.models.save(basic_model)
    collection.models.setCurrent(basic_model)
    fact = collection.newNote()

    mp3_filename = mp3_path + str(
        base64.b32encode(bytes(word, encoding="utf8")[:30]))
    tts.save(mp3_filename)
    fact['Front'] = "[sound:{audio_filename}] <br> {word}".format(
        audio_filename=mp3_filename, word=word)

    fact['Back'] = word

    collection.addNote(fact)

    collection.save()
collection.close()
