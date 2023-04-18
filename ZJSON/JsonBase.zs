class placeholder_JsonElementOrError {}

class placeholder_JsonElement : placeholder_JsonElementOrError abstract
{
	abstract string Serialize();
	abstract string GetPrettyName();
}

class placeholder_JsonNumber : placeholder_JsonElement abstract
{
	abstract placeholder_JsonNumber Negate();
	abstract double  asDouble();
	abstract int asInt();
	
	override string GetPrettyName()
	{
		return "Number";
	}
}

class placeholder_JsonInt : placeholder_JsonNumber
{
	int i;
	
	static placeholder_JsonInt make(int i = 0)
	{
		let elem = new("placeholder_JsonInt");
		elem.i = i;
		return elem;
	}
	override placeholder_JsonNumber Negate()
	{
		i = -i;
		return self;
	}
	override string Serialize()
	{
		return ""..i;
	}
	
	override double asDouble()
	{
		return double(i);
	}
	
	override int asInt()
	{
		return i;
	}
}

class placeholder_JsonDouble : placeholder_JsonNumber
{
	double d;
	
	static placeholder_JsonDouble Make(double d = 0)
	{
		placeholder_JsonDouble elem = new("placeholder_JsonDouble");
		elem.d = d;
		return elem;
	}
	override placeholder_JsonNumber Negate()
	{
		d = -d;
		return self;
	}
	override string Serialize()
	{
		return ""..d;
	}
	
	override double asDouble()
	{
		return d;
	}
	
	override int asInt()
	{
		return int(d);
	}
}

class placeholder_JsonBool : placeholder_JsonElement
{
	bool b;
	
	static placeholder_JsonBool Make(bool b = false)
	{
		placeholder_JsonBool elem = new("placeholder_JsonBool");
		elem.b = b;
		return elem;
	}
	
	override string Serialize()
	{
		return b? "true" : "false";
	}
	
	override string GetPrettyName()
	{
		return "Bool";
	}
}

class placeholder_JsonString : placeholder_JsonElement
{
	string s;
	
	static placeholder_JsonString make(string s = "")
	{
		placeholder_JsonString elem = new("placeholder_JsonString");
		elem.s=s;
		return elem;
	}
	
	override string Serialize()
	{
		return placeholder_JSON.serialize_string(s);
	}
	
	override string GetPrettyName()
	{
		return "String";
	}
}

class placeholder_JsonNull : placeholder_JsonElement
{
	static placeholder_JsonNull Make()
	{
		return new("placeholder_JsonNull");
	}
	
	override string Serialize()
	{
		return "null";
	}
	
	override string GetPrettyName()
	{
		return "Null";
	}
}

class placeholder_JsonError : placeholder_JsonElementOrError
{
	String what;
	
	static placeholder_JsonError make(string s)
	{
		placeholder_JsonError err = new("placeholder_JsonError");
		err.what = s;
		return err;
	}
}