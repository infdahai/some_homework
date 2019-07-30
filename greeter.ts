class Site {
    name(): void {
        console.log("Run")
    }
}

var obj = new Site();
obj.name();


class Student {
    fullname: string;
    constructor(public firstName: string, public middleInitial: string, public lastName: string) {
        this.fullname = firstName + " " + middleInitial + " " + lastName;
    }
}

function greeter(person: Person) {
    return "Hello, " + person.firstName + " " + person.lastName;
}

interface Person {
    firstName: string;
    lastName: string;
}

let user = new Student("Jane", "M", "User");
window.document.body.innerHTML = greeter(user);


let x: never | number;
let y: number;

x = 123;
x = (() => { throw new Error('exception') })();

function error(message: string): never {
    throw new Error(message);
}

function loop(): never {
    while (true) { }
}

var global_numer = 123

class Number_ {
    num_val = 12;
    static sval = 10;
    storeNum(): void {
        var local_num = 14;
    }
}

var num = 12
console.log(typeof num)

let list = [1, 2, 3];
list.every((val, idx, array) => {
    return true;
})

function buildName1(firstName: string, lastName?: string): string {
    if (lastName)
        return firstName + " " + lastName;
    else
        return firstName;
}
function buildName2(firstName: string, ...resOfName: string[]): string {
    return firstName + " " + resOfName.join(" ");
}
function calculate_discount(price: number, rate: number = 0.50) {
    var discount = price * rate;
    console.log("计算结果: ", discount);
}

function addNumber(...nums: number[]) {
    var i;
    var sum: number = 0;
    for (let j of nums) {
        sum += j;
    }
    return sum;
}

var msg = function () {
    return 'hello world';
}
console.log(msg());

(function () {
    var x = "hello world";
    console.log(x);
})()


var foo = (x: number) => 10 + x
console.log(foo(1))


var func = (x) => {
    switch (typeof x) {
        case 'number':
            console.log('number');
            break;
        case 'string':
            console.log('string');
            break;
        default:
            console.log('type error');

    }

}


function employee(id, name) {
    this.id = id;
    this.name = name;
}

var emp = new employee(123, "admin");
employee.prototype.email = "admin@runoob.com";

var arr_names: number[] = new Array(4)
for (let i = 0; i < arr_names.length; i++) {
    arr_names[i] = i * 2;
    console.log(arr_names[i]);
}

// array
var arr: number[] = [12, 13]
var [a, b] = arr
console.log(a, b)

// tuple
var [c, d] = [1, 2]

// union
function disp_(name: string | string[]) {
    if (typeof name == 'string')
        console.log(name)
    else {
        for (let i = 0; i < name.length; i++) {
            const element = name[i];
            console.log(element);
        }
    }
}

//interface
interface IPerson {
    firstName: string,
    lastName: string,
    sayHi: () => string
}

var customer: IPerson = {
    firstName: "Tom",
    lastName: "Hanks",
    sayHi: (): string => { return "Hi there" }
}

interface namelist {
    [index: number]: string
}
var list2: namelist = ["john", "brain"]


interface Per {
    age: number
}

interface Musician extends Per {
    instrument: string
}

var dummer = <Musician>{};

interface IParent1 {
    v1: number
}

interface IParent2 {
    v2: number
}

// multi-inherit  : interface
interface Child extends IParent1, IParent2 { }
var Iobj: Child = { v1: 12, v2: 23 }
console.log("value 1: " + Iobj.v1 + " value 2: " + Iobj.v2)


class Car {
    engine: string;
    constructor(engine: string) {
        this.engine = engine;
    }
    disp(): void {
        console.log(this.engine);
    }


}

var obj1 = new Car("XXSY1")


class Shape {
    Area: number

    constructor(a: number) {
        this.Area = a
    }

}

class Circle extends Shape {
    disp(): void {
        console.log("圆的面积:  " + this.Area)
    }
}
var obj2 = new Circle(123);
obj2.disp()

// class unsupport mutli-class-inherit
class Root {
    str1: string;
}

class Childs extends Root { }
class Leaf extends Childs { } // 多重继承，继承了 Child 和 Root 类

var obj3 = new Leaf();
obj3.str1 = "hello"
console.log(obj3.str1)


class Printclass {
    doPrint(): void {
        console.log("父类的 doPrint() 方法。")
    }
}

class StringPrinter extends Printclass {
    doPrint(): void {
        super.doPrint()
        console.log("子类的 doPrint()方法。")
    }
}


class StaticMem {
    static num: number;

    static disp(): void {
        console.log("num 值为 " + StaticMem.num)
    }
}


StaticMem.num = 12

interface ILoan {
    interest: number
}

class AgriLoan implements ILoan {
    interest: number
    rebate: number

    constructor(interest: number, rebate: number) {
        this.interest = interest
        this.rebate = rebate
    }
}


//对象是包含一组键值对的实例。


interface IPoint {
    x: number
    y: number
}
function addPoints(p1: IPoint, p2: IPoint): IPoint {
    var x = p1.x + p2.x
    var y = p1.y + p2.y
    return { x: x, y: y }
}


namespace someNameSpace {
    export interface ISomeInterfaceName { }
    export class SomeClassName { }
}

declare var jQuery: (selector: string) => any;

jQuery('#foo');
