void initializePlaylists(){
  //Adding all the songs to defult playlist
  defaultPlaylist.add(new Song(this,"Benzi Box.mp3","Mouse and the Mask", "Mouse and the Mask.jpeg"));
  defaultPlaylist.add(new Song(this, "Doomsday.mp3", "Operation: DOOMSDAY","Operation Doomsday Album Cover.jpeg" ));
  defaultPlaylist.add(new Song(this, "Rhymes Like Dimes.mp3", "Operation: DOOMSDAY","Operation Doomsday Album Cover.jpeg" ));
  defaultPlaylist.add(new Song(this, "Potholderz.mp3", "MM Food","MM Food.jpeg" ));
  defaultPlaylist.add(new Song(this, "Deep Fried Frenz.mp3", "MM Food","MM Food.jpeg" ));
  defaultPlaylist.add(new Song(this, "Crosshairs.mp3", "Mouse and the Mask","Mouse and the Mask.jpeg" ));
  defaultPlaylist.add(new Song(this, "Darling I.mp3","Chromakopia","Chromakopia Album.jpeg" ));
  defaultPlaylist.add(new Song(this,"St Chroma.mp3","Chromakopia","Chromakopia Album.jpeg"));
  defaultPlaylist.add(new Song(this,"See You Again.mp3","Flower Boy","Flower Boy.jpeg"));
  defaultPlaylist.add(new Song(this,"911: Mr lonely.mp3","Flower Boy","Flower Boy.jpeg"));
  defaultPlaylist.add(new Song(this,"Pink White.mp3","Blonde","Blonde.jpeg"));
  defaultPlaylist.add(new Song(this,"Goodbye Angels.mp3","The Getaway","The Getaway.jpeg"));
  defaultPlaylist.add(new Song(this,"Sick Love.mp3","The Getaway","The Getaway.jpeg"));
  defaultPlaylist.add(new Song(this,"White Braids & Pillow Chair.mp3","Unlimited Love","Unlimited Love.jpeg"));
  defaultPlaylist.add(new Song(this,"Black Summer.mp3","Unlimited Love","Unlimited Love.jpeg"));
  defaultPlaylist.add(new Song(this,"Billie Jean.mp3","Thriller","Thriller.jpeg"));


  

  //Setting up  playlist1
  playlist1.add(new Song(this,"Potholderz.mp3", "MM Food","MM Food.jpeg" ));
  playlist1.add(new Song(this,"Black Summer.mp3","Unlimited Love","Unlimited Love.jpeg"));
  playlist1.add(new Song(this,"St Chroma.mp3","Chromakopia","Chromakopia Album.jpeg"));
  playlist1.add(new Song(this,"911: Mr lonely.mp3","Flower Boy","Flower Boy.jpeg"));
  playlist1.add(new Song(this, "Crosshairs.mp3", "Mouse and the Mask","Mouse and the Mask.jpeg" ));
  playlist1.add(new Song(this,"Pink White.mp3","Blonde","Blonde.jpeg"));


  //Setting up playlist2
  playlist2.add(new Song(this, "Rhymes Like Dimes.mp3", "Operation: DOOMSDAY","Operation Doomsday Album Cover.jpeg" ));
  playlist2.add(new Song(this, "Doomsday.mp3", "Operation: DOOMSDAY","Operation Doomsday Album Cover.jpeg" ));
  playlist2.add(new Song(this,"Benzi Box.mp3","Mouse and the Mask", "Mouse and the Mask.jpeg"));
  playlist2.add(new Song(this,"Billie Jean.mp3","Thriller","Thriller.jpeg"));
  playlist2.add(new Song(this,"See You Again.mp3","Flower Boy","Flower Boy.jpeg"));
  playlist2.add(new Song(this, "Crosshairs.mp3", "Mouse and the Mask","Mouse and the Mask.jpeg" ));
  playlist2.add(new Song(this,"Goodbye Angels.mp3","The Getaway","The Getaway.jpeg"));
  playlist2.add(new Song(this,"St Chroma.mp3","Chromakopia","Chromakopia Album.jpeg"));
  playlist2.add(new Song(this, "Darling I.mp3","Chromakopia","Chromakopia Album.jpeg" ));


  
  //Adding all the playlists to 2d array
  allPlaylists.add(defaultPlaylist);
  allPlaylists.add(playlist1);
  allPlaylists.add(playlist2);  

}