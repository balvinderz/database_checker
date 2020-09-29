class Scripts
{
  bool groupScript,pageScript,instaScript,runnerScript;
  String runnerFile,groupFile,pageFile,instaFile;

  Scripts.fromMap(Map map):
      groupScript = map['group_script'],
  instaScript = map['insta_script'],
  runnerScript = map['runner_script'],
  runnerFile = map['runner_file'] ??"",
  instaFile = map['insta_file'] ?? "",
  pageFile = map['page_file'] ?? "",
  groupFile = map['group_file'] ?? "",

  pageScript = map['page_script'];

}