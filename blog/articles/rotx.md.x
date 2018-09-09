---
layout: blog-post
title: "ROTx"
author: "Mark Honeychurch"
date: 2008/03/16
---

I became interested in cryptography a few years ago, and have been slowly working my way through Bruce Schneier's [Applied Cryptography](http://www.schneier.com/book-applied.html). From this, I became interested in simple forced decryption (cracking) of cyphers, and directed my attention to the ROT13 algorythm.


ROT13 is one of the simplest encryption techniques around, and most kids learn it as a fun way to obscure text. Basically, the idea is to rotate each letter by 13 characters, therefore a 'A' becomes 'A' + 13, which is 'N'. Similarly, 'B' becomes 'O', 'C' becomes 'P' and so on. When we get to the second half of the alphabet, the letters wrap round, so 'M' becomes 'Z', 'N' becomes 'A', etc. The easiest way to use this technique is with a substitution table, as below:


<code>
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z

N O P Q R S T U V W X Y Z A B C D E F G H I J K L M
</code>


To use the table, for each character that needs to be changed find the character in the upper row and replace it with the corresponding character in the bottom row. Of course, with a cypher this simple some tricks are employed to maintain consistency. Firstly, punctuation and spaces are not encrypted. Secondly, lower and upper case letters are both treated in the same way. Implementing these ideas in PHP is fairly simple.


The idea I came up with was that the rotation of 13 characters for ROT13 can be changed with any integer from 1 to 25, and I call this ROTx. The challenge is to decypher text that has been encrypted with an unknown integer.


The method for decryption is fairly simple, and involves comparing the letter frequency of our encrypted text with known average letter frequencies for the English Language. This has the limitation that it'll only work reliably for English text, but letter frequency tables for different languages can be substituted depending on the language the cypher text is in.
<table><th>Letter</th><td>A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td><td>G</td><td>H</td><td>I</td><td>J</td><td>K</td><td>L</td><td>M</td></tr>
<tr><th>Frequency (%)</th><td>8.167</td><td>1.492</td><td>2.782</td><td>4.253</td><td>12.702</td><td>2.228</td><td>2.015</td><td>6.094</td><td>6.966</td><td>0.153</td><td>0.772</td><td>4.025</td><td>2.406</td></tr>
<tr><th>Letter</th><td>N</td><td>O</td><td>P</td><td>Q</td><td>R</td><td>S</td><td>T</td><td>U</td><td>V</td><td>W</td><td>X</td><td>Y</td><td>Z</td></tr>
<tr><th>Frequency (%)</th><td>6.749</td><td>7.507</td><td>1.929</td><td>0.095</td><td>5.987</td><td>6.327</td><td>9.056</td><td>2.758</td><td>0.978</td><td>2.360</td><td>0.150</td><td>1.974</td><td>0.074</td></tr></table>


The frequency table I have used above comes from [Wikipedia](http://en.wikipedia.org/wiki/Letter_frequency). My PHP code calculates the letter frequency of the cypher text and then tries to match this frequency map with that of the reference frequency table. The program rotates the frequency table one letter at a time, adds up all the differences between the frequency of each letter and the expected frequency and keeps a record of the total. The lowest total of all the rotations is taken to be the best fit to the text and hence the correct decryption.


Of course clever things could be done with dictionary lookups, first/last letter frequencies (which will differ from overall letter frequencies) and the like, but as it is I was quite surprised with how little text the program needs to correctly guess the correct plaintext. Single letters such as 'Hello' are decyphered successfully.


For now, until I've figured out how Drupal's Forms API works, the form below won't work.
<?php
/*
class cipher
{
 public $plainText;
 public $encodedText;
 public $rotation;
 private $englishLetterFrequencies = array(0.08167, 0.01492, 0.02782, 0.04253, 0.12702, 0.02228, 0.02015, 0.06094, 0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749, 0.07507, 0.01929, 0.00095, 0.05987, 0.06327, 0.09056, 0.02758, 0.00978, 0.02360, 0.00150, 0.01974, 0.00074);

 function rotateLetter($letter) {
 $inverseRotation = (26 - $rotation);
 $upperCaseStart = ord('A');
 $upperCaseEnd = $upperCaseStart + 25;
 $upperCaseMiddle = $upperCaseEnd - $rotation;
 $lowerCaseStart = ord('a');
 $lowerCaseEnd = $lowerCaseStart + 25;
 $lowercaseMiddle = $lowerCaseEnd - $rotation;
 if ($letter <= $lowerCaseEnd) {
  if ($letter >= $lowerCaseMiddle) {
   return $letter - $inverseRotation;
  }
  if ($letter >= $lowerCaseStart) {
   return $letter + $rotation;
  }
  if ($letter <= $upperCaseEnd) {
   if ($letter >= $upperCaseMiddle) {
    return $letter - $inverseRotation;
   }
   if ($letter >= $upperCaseStart) {
    return $letter + $rotation;
   }
  }
  return $letter;
 }

 function rotateText() {
  for ($i = 0; $i < strlen($this->plainText); $i++)
   $this->encodedText .= chr(rotateLetter(ord($this->plainText{$i})));
  }
 }

 function findFrequencies() {
  for ($i = 0; $i < strlen($this->plainText); $i++) {
   $letter = ord($this->plainText{$i});
   if (($letter >= $lowerCaseStart) && ($letter <= $lowerCaseEnd)) {
    $frequencies[$letter - $lowerCaseStart]++;
   }
   else if (($letter >= $upperCaseStart) && ($letter <= $upperCaseEnd)) {
    $frequencies[$letter - $upperCaseStart]++;
   }
  }
  $letterTotal = array_sum($frequencies);
  for ($i = 0; $i < 26; $i++) {
   $frequencies[$i] /= $letterTotal;
  }
  for ($i = 1; $i < 26; $i++) {
   $frequencies[25] = array_shift($frequencies);
   for ($j = 0; $j < 26; $j++) {
    $shiftDifference[$i] += abs($englishLetterFrequencies[$j] - $frequencies[$j]);
   }
  }
  $minDifference = min($shiftDifference);
  $shiftDifferenceFlip = array_flip($shiftDifference);
  $minPosition = $shiftDifferenceFlip[$minDifference];
 }

}
*/
?>

<?php
if (isset($_POST['Submit']))
{
 $code = new cipher();
 if ($_POST['action'] == 'encode') {
  $code->plainText = $_POST['text'];
  $code->rotation = $_POST['rotation'];
  echo $code->plainText;
 } else {
  $code->encodedText = $_POST['text'];
 }

}
?>
<form enctype="multipart/form-data" method="post" action="/node/9">
<fieldset id="rotdata">
<input type="radio" name="action" value="encode" id="encode" checked="checked" /><label for="encode">Encode</label> with <label for="ROT">ROT</label>
<select name="rotation">
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<option value="11">11</option>
<option value="12">12</option>
<option value="13" selected="selected">13</option>
<option value="14">14</option>
<option value="15">15</option>
<option value="16">16</option>
<option value="17">17</option>
<option value="18">18</option>
<option value="19">19</option>
<option value="20">20</option>
<option value="21">21</option>
<option value="22">22</option>
<option value="23">23</option>
<option value="24">24</option>
<option value="25">25</option>
</select>


<input type="radio" name="action" value="decode" id="decode" /><label for="decode">Decode</label>

<textarea name="text" rows="8" cols="80"></textarea>
<input type="submit" name="submit" value="Submit" />
</fieldset>
</form>

