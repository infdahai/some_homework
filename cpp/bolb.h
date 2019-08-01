#include <memory>
#include <string>
#include <vector>



class StrBlobPtr;

class StrBlob {
  friend class  StrBlobPtr ;

  StrBlobPtr begin() ;
  StrBlobPtr end() ;

public:
  typedef std::vector<std::string>::size_type size_type;
  StrBlob() : data(std::make_shared<std::vector<std::string>>()) {}
  StrBlob(std::initializer_list<std::string> i1)
      : data(std::make_shared<std::vector<std::string>>(i1)) {}
  size_type size() const { return data->size(); }
  bool empty() const { return data->empty(); }
  void pop_back();
  void push_back(const std::string &t) { data->push_back(t); }
  std::string &front();
  std::string &back();

private:
  std::shared_ptr<std::vector<std::string>> data;
  void check(size_type i, const std::string &msg = "error") const;
};


class StrBlobPtr {
public:
  StrBlobPtr() : curr(0) {}
  StrBlobPtr(StrBlob &a, std::size_t sz = 0) : wptr(a.data), curr(sz) {}
  std::string &deref() const;
  StrBlobPtr &incr();

private:
  std::shared_ptr<std::vector<std::string>> check(std::size_t,
                                                  const std::string &) const;
  std::weak_ptr<std::vector<std::string>> wptr;
  std::size_t curr;
};

std::shared_ptr<std::vector<std::string>>
StrBlobPtr::check(std::size_t i, const std::string &msg) const {
  auto ret = wptr.lock();
  if (!ret)
    throw std::runtime_error("unbounded StrBlobPtr");
  if (i >= ret->size())
    throw std::out_of_range(msg);
  return ret;
}

std::string &StrBlobPtr::deref() const {
  auto p = check(curr, "dereference past end");
  return (*p)[curr];
}

StrBlobPtr &StrBlobPtr::incr() {
  check(curr, "increment past end of StrBlobPtr");
  ++curr;
  return *this;
}