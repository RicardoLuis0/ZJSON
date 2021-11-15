class placeholder_JsonElementOrError {
}

class placeholder_JsonElement : placeholder_JsonElementOrError abstract {
	abstract string serialize();
}

class placeholder_JsonNumber : placeholder_JsonElement abstract {
	abstract placeholder_JsonNumber negate();
}

class placeholder_JsonInt : placeholder_JsonNumber {
	int i;
	static placeholder_JsonInt make(int i=0){
		placeholder_JsonInt ii=new("placeholder_JsonInt");
		ii.i=i;
		return ii;
	}
	override placeholder_JsonNumber negate(){
		i=-i;
		return self;
	}
	override string serialize(){
		return ""..i;
	}
}

class placeholder_JsonDouble : placeholder_JsonNumber {
	double d;
	static placeholder_JsonDouble make(double d=0){
		placeholder_JsonDouble dd=new("placeholder_JsonDouble");
		dd.d=d;
		return dd;
	}
	override placeholder_JsonNumber negate(){
		d=-d;
		return self;
	}
	override string serialize(){
		return ""..d;
	}
}

class placeholder_JsonBool : placeholder_JsonElement {
	bool b;
	static placeholder_JsonBool make(bool b=false){
		placeholder_JsonBool bb=new("placeholder_JsonBool");
		bb.b=b;
		return bb;
	}
	override string serialize(){
		return b?"true":"false";
	}
}

class placeholder_JsonString : placeholder_JsonElement {
	string s;
	static placeholder_JsonString make(string s=""){
		placeholder_JsonString ss=new("placeholder_JsonString");
		ss.s=s;
		return ss;
	}
	override string serialize(){
		return placeholder_JSON.serialize_string(s);
	}
}

class placeholder_JsonNull : placeholder_JsonElement {
	static placeholder_JsonNull make(){
		return new("placeholder_JsonNull");
	}
	override string serialize(){
		return "null";
	}
}

class placeholder_JsonError : placeholder_JsonElementOrError {
	String what;
	static placeholder_JsonError make(string s){
		placeholder_JsonError e=new("placeholder_JsonError");
		e.what=s;
		return e;
	}
}