---
layout: blog-post
title: "Downloading Music Artist Images"
author: "Mark Honeychurch"
date: 2008-07-08
---

I was cleaning up my music collection yesterday by using [Discogs](http://www.discogs.com/), a great online Discography catalogue website, to download missing album cover art. I normally use the long-windedly named [Album Cover Art Downloader](http://www.unrealvoodoo.org/hiteck/projects/albumart/) to download cover art, as it's pretty good and can grab images from various sources (amazon.com, yahoo, buy.com) - but there are some albums, especially bootlegs and the like, that aren't on Amazon. While using Discogs I saw that they have artist images (such as the one on the right), and started to download these to use like Album Art images, by naming the file folder.jpg and placing it in the artist's folder (My music collection is organised by First Letter\Artist\Album, e.g. A\Aphex Twin\Hangable Autobulb).

Of course, I quickly realised that this would take a while to complete, so I searched for any software which took advantage of the Discogs catalogue. Although Wikipedia's page on [Discogs](http://en.wikipedia.org/wiki/Discogs) had a list of [software](http://en.wikipedia.org/wiki/Discogs#Software) which uses the Discogs catalog
, there wasn't any cover art downloading software listed. After a search on google, I found a slightly shorter named piece of software called [Album Art Downloader](http://sourceforge.net/projects/album-art) on Sourceforge. This new piece of software does a similar job to Album Cover Art Downloader, but has a lot more plugins to search different sites for album art - including Discogs.

So, after adding a list item for Album Art Downloader to the Wikipedia page, I downloaded installed the software. The Discogs plugin is capable of downloading album art images, which is great, but doesn't download artist images. As Album Art Downloader uses a plugin architecture, I figured it wouldn't be too hard to hack the existing Discogs script to use it for artist images. The existing plugin is at C:\Program Files\AlbumArtDownloader\Scripts\discogs.boo, and it consists of the following code:

```csharp
namespace CoverSources
import System
import System.Text
import System.Text.RegularExpressions
import util

class Discogs:
 static SourceName as string:
  get: return "Discogs"
 static SourceCreator as string:
  get: return "Alex Vallat"
 static SourceVersion as string:
  get: return "0.4"
 static def GetThumbs(coverart,artist,album):
  query as string = artist + " " + album
  query.Replace(' ','+')
  obidResults = GetPage(String.Format("http://www.discogs.com/search?type=all&amp;q={0}", EncodeUrl(query)))

  //Get obids
  obidRegex = Regex("<a href="http://www.blogger.com/" obid="" release="">\\d+)\"&gt;]+&gt;(?:&lt;/?em&gt;|(?<name>[^&lt;]+))+</name>", RegexOptions.Multiline)
  obidMatches = obidRegex.Matches(obidResults)
  coverart.EstimatedCount = obidMatches.Count //Probably more than this, as some releases might have multiple images

  for obidMatch as Match in obidMatches:
   //Construct the release name by joining up all the captures of the "name" group
   releaseNameBuilder = StringBuilder()
   for namePart in obidMatch.Groups["name"].Captures:
    releaseNameBuilder.Append(namePart)

   releaseName = releaseNameBuilder.ToString()

   //Get the image results
   imageResults = GetPage(String.Format("http://www.discogs.com/viewimages?what=R&amp;obid={0}&amp;showpending=1", obidMatch.Groups["obid"].Value))

   imageRegex = Regex("<img src="\" url="" />http://www\\.discogs\\.com/image/R-\\d+-\\d+.(?:jpe?g|gif|png))\" width=\"(?<width>\\d+)\" height=\"(?<height>\\d+)\"")
   imageMatches = imageRegex.Matches(imageResults)

   coverart.EstimatedCount += imageMatches.Count - 1 //Adjust count by how many images for this release

   for imageMatch as Match in imageMatches:
    coverart.Add(imageMatch.Groups["url"].Value, releaseName, Int32.Parse(imageMatch.Groups["width"].Value), Int32.Parse(imageMatch.Groups["height"].Value), null)

 static def GetResult(param):
  return param
```

Well, I figured it wouldn't be too hard to make a copy of this and edit it to download artist images. The main changes need to be to change the Class name (to DiscogsArtist), change the plugin details, make the first search look for artists only (change _query as string = artist + " " + album_ to _query as string = album_), remove the extra code between the artist/album search and the image search and change the RegEx search for images within the page to search for files beginning with _A-_ (Artist) instead of _R-_ (Release).

What we come up with is the following script:

```csharp
namespace CoverSources
import System
import System.Text
import System.Text.RegularExpressions
import util

class DiscogsArtist:
 static SourceName as string:
  get: return "Discogs Artist"
 static SourceCreator as string:
  get: return "Mark Honeychurch"
 static SourceVersion as string:
  get: return "0.1"
 static def GetThumbs(coverart,artist,album):
  query as string = album
  query.Replace(' ','+')

  //Get the image results
  imageResults = GetPage(String.Format("http://www.discogs.com/viewimages?artist={0}", EncodeUrl(query)))

  imageRegex = Regex("<img src="\" url="" />http://www\\.discogs\\.com/image/A-\\d+-\\d+.(?:jpe?g|gif|png))\" width=\"(?<width>\\d+)\" height=\"(?<height>\\d+)\"")
  imageMatches = imageRegex.Matches(imageResults)

  coverart.EstimatedCount += imageMatches.Count - 1 //Adjust count by how many images for this release

  for imageMatch as Match in imageMatches:
   coverart.Add(imageMatch.Groups["url"].Value, artist, Int32.Parse(imageMatch.Groups["width"].Value), Int32.Parse(imageMatch.Groups["height"].Value), null)

 static def GetResult(param):
  return param
```

I saved this as _discogartists.boo_ and copied it to the plugins directory. When I first started up Album Art Downloader, I received complaints about indenting - as it turns out that indenting is used to mark loops and the like in the plugin. After fixing the indenting, Album Art Downloader ran without any complaints - woo hoo!

Using the plugin is a bit of a fudge! First, to make sure each artist's folder shows up we need to have at least one file in each of them. My quick fix was to browse through each of the folders containing artists in turn, turning on the _Thumbnails_ view. This causes windows to create a Thumbs.db file in each artist's folder.

Run Album Art Downloader, and then ensure that only the _Discogs Artists_ plugin is selected in the _Sources:_ box on the right. Next click on _File, New, File Browser_. In the browser window, first click on the _Options..._ to expand the Options panel, then ensure the _Include subfolders when searching for audio files_ tickbox is checked and select the _Use file path pattern matching:_ radio button. Click the _Search_ button in the top-right of the window, and then once the search has completed click the _Artist_ column header to organise the results by Artist name. Now look for all the results grouped together with the parent folder (in my case, A-Z) name as the _Artist_ name. Tick each of the boxes and then click on the _Get Artwork for Selection..._ button in the bottom-right of the window. Now for each window that pops up, select the image you'd like (left-click on the image to ee a full size version) and click the floppy disc button to save the file to your artist's folder as folder.jpg.
