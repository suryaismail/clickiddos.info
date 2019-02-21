function check1() {
  var x = document.getElementById("input1").value;
  if (x == '5021') {
    alert('You solved problem 1!');
  } else {
    alert('Hmm, try that again.')
  }
}

function check2() {
  var x = document.getElementById("input2").value;
  var ans = x.split(/\r|\n/).map(item => item.trim()).filter(Boolean);

  var s = 21;
  var e = 44;
  //var correctAns = [];
  for (var i = s; i <= e; i++) {
    if (i % 3 == 0) {
      if (i % 5 == 0) {
        if (ans[i - s] != 'FizzBuzz') {
          alert("Um, try again");
          return;
        }
        //correctAns[i - s] = 'FizzBuzz';
      } else {
        if (ans[i - s] != 'Fizz') {
          alert("Um, try again");
          return;
        }
        //correctAns[i - s] = 'Fizz';
      }
    } else if (i % 5 == 0) {
      if (ans[i - s] != 'Buzz') {
        alert("Um, try again");
        return;
      }
      //correctAns[i - s] = 'Buzz';
    } else {
      if (ans[i - s] != i) {
        alert("Um, try again");
        return;
      }
      //correctAns[i - s] = "" + i;
    }
  }
  alert("You're right!");
}

String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};

function strMatch(num, str) {
  var numStr = num.toString().split("");
  for (var i = 0; i < str.length; i++) {
    if (str[i] != '?') {
      if (numStr[i] != str[i]) {
        return false;
      }
    }
  }
  return true;
}

function check3() {
  var s = "?2?"; // "??3";
  var e = "??9"; // "?24";
  var s_charArr = s.split("");
  var e_charArr = e.split("");
  var s0 = s;
  var e0 = e;

  if (s0.charAt(0) == '?') {
    s0 = '1' + s0.substring(1, s.length);
  }
  s0 = s0.replaceAll(/\?/, '0');
  e0 = e0.replaceAll(/\?/, '9')

  var si = parseInt(s0, 10);
  var ei = parseInt(e0, 10);

  var ans = [];
  for (i = si; i < ei; i++) {
    if (strMatch(i, s_charArr) && strMatch((i + 1), e_charArr)) {
      ans.push(i + " " + (i + 1));
    }
  }

  var x = document.getElementById("input3").value;
  var inputAns = x.split(/\r|\n/).map(item => item.trim()).filter(Boolean);
  for (i = 0; i < ans.length; i++) {
    if (ans[i] != inputAns[i]) {
      alert("Oopps, try again");
      return;
    }
  }
  alert("Success!!!");
}
