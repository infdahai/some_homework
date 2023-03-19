#include "bolb.h"
#include <iostream>

void StrBlob::check(StrBlob::size_type i, const std::string &msg) const {
  if (i >= data->size())
    throw std::out_of_range(msg);
}

std::string &StrBlob::front() {
  check(0, "front on empty StrBlob");
  return data->front();
}

std::string &StrBlob::back() {
  check(0, "pop back on empty StrBlob");
  return data->back();
}
/*
struct destination;
enum connect_status { OK, NOT_Ok };
struct connection {
  connect_status status;
  int Error_code;
};
connection connect(destination *);
void disconnect(connection);
void end_connection(connection *p) { disconnect(*p); }
void f(destination &d) {
  connection c = connect(&d);
  std::shared_ptr<connection> p (&c,end_connection);
}

void g(destination &d)
{
    connection c = connect(&d);
    std::shared_ptr<connection> p (&c,[](connection *p){disconnect(*p);});
}

void h(destination& d)
{
    connection c = connect(&d);
    std::unique_ptr<connection,decltype(end_connection)*>p(&c,end_connection);
}
*/
StrBlobPtr StrBlob::begin() { return StrBlobPtr(*this); }
StrBlobPtr StrBlob::end() { return StrBlobPtr(*this, data->size()); }

int main() {
  std::unique_ptr<int[]> up(new int[10]());
  up.release();
  std::shared_ptr<int> sp(new int[10], [](int *p) { delete[] p; });
  sp.reset();
  //  std::cout<<std::endl;
  int n = 10;
  std::allocator<std::string> alloc;
  auto const p = alloc.allocate(n);


  auto q = p;
  alloc.construct(q++);
  alloc.construct(q++,10,'c');
  alloc.construct(q++,"hi");

  std::cout<<*p<<std::endl;
  std::cout<<*q<<std::endl;
  while(q!=p)
    alloc.destroy(--q);



  return 0;
}