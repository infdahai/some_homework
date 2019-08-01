#include <iostream>
#include <map>
#include <memory>
#include <set>
#include <sstream>
#include <string>
#include <vector>

using namespace std;
class QueryResult;
using line_no = std::vector<std::string>::size_type;

string make_plural(size_t ctr, const string &word, const string &ending) {
  return (ctr == 1)
             ? word
             : word +
                   ending; // make_plural(wc, "word ", "s ")当输入中文本中
                           // word数大于一是在word后加s，为words为word的复数！
}

class TextQuery {
public:
  TextQuery(std::ifstream &);
  QueryResult query(const std::string &) const;
  ~TextQuery();

private:
  std::shared_ptr<std::vector<std::string>> file;
  std::map<std::string, std::shared_ptr<std::set<line_no>>> wm;
};

TextQuery::TextQuery(std::ifstream &is) : file(new std::vector<std::string>) {
  string text;
  while (getline(is, text)) {
    file->push_back(text);
    int n = file->size() - 1;
    istringstream line(text);
    string word;
    while (line >> word) {
      auto &lines = wm[word];
      if (!lines) {
        lines.reset(new set<line_no>);
      }
      lines->insert(n);
    }
  }
}

TextQuery::~TextQuery() {}

class QueryResult {
  friend std::ostream &print(std::ostream &, const QueryResult &);

public:
  QueryResult(std::string s, std::shared_ptr<std::set<line_no>> p,
              std::shared_ptr<std::vector<std::string>> f)
      : sought(s), lines(p), file(f){};

private:
  string sought;
  shared_ptr<set<line_no>> lines;
  shared_ptr<vector<string>> file;
};

QueryResult TextQuery::query(const string &sought) const {
  static shared_ptr<set<line_no>> nodata(new set<line_no>);
  auto loc = wm.find(sought);
  if (loc == wm.end())
    return QueryResult(sought, nodata, file);
  else
    return QueryResult(sought, loc->second, file);
}

ostream &print(ostream &os, const QueryResult &qr) {
  os << qr.sought << " occurs " << qr.lines->size() << " "
     << make_plural(qr.lines->size(), "time", "s") << endl;
  for (auto num : *qr.lines)
    os << "\t(line " << num + 1 << ")  " << *(qr.file->begin() + num) << endl;
  return os;
}

void runQueries(ifstream &infile) {
    TextQuery tq(infile);
    while(true){
        cout<<"enter word to look for, or q to quit: ";
        string s;
        if(!(cin>>s)|| s=="q") break;
        print(cout,tq.query(s))<<endl;
    }
}
