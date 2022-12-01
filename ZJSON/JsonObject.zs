
class placeholder_JsonObjectKeys {
	Array<String> keys;
}


class placeholder_JsonObject : placeholder_JsonElement {
	Map<String,placeholder_JsonElement> data;
	
	static placeholder_JsonObject make(){
		return new("placeholder_JsonObject");
	}
	
	placeholder_JsonElement Get(String key){
		if(!data.CheckKey(key)) return null;
		return data.Get(key);
	}
	
	void Set(String key,placeholder_JsonElement e){
		data.Insert(key,e);
	}
	
	bool Insert(String key,placeholder_JsonElement e){//only inserts if key doesn't exist, otherwise fails and returns false
		if(data.CheckKey(key)) return false;
		data.Insert(key,e);
		return true;
	}
	
	bool Delete(String key){
		if(!data.CheckKey(key)) return false;
		data.Remove(key);
		return true;
	}
    
	void GetKeysInto(out Array<String> keys){
		keys.Clear();
		MapIterator<String,placeholder_JsonElement> it;
		it.Init(data);
		while(it.Next()){
			keys.Push(it.GetKey());
		}
	}
    
	placeholder_JsonObjectKeys GetKeys(){
		placeholder_JsonObjectKeys keys = new("placeholder_JsonObjectKeys");
        GetKeysInto(keys.keys);
		return keys;
	}
    
    deprecated("0.0", "Use IsEmpty Instead") bool empty() {
        return data.CountUsed() == 0;
    }

	bool IsEmpty(){
		return data.CountUsed() == 0;
	}
	
	void Clear(){
		data.Clear();
	}
	
	uint size(){
		return data.CountUsed();
	}
	
	override string serialize(){
		String s;
		s.AppendCharacter(placeholder_JSON.CURLY_OPEN);
		bool first = true;
		
		MapIterator<String,placeholder_JsonElement> it;
		it.Init(data);
		
		while(it.Next()){
			if(!first){
				s.AppendCharacter(placeholder_JSON.COMMA);
			}
			s.AppendFormat("%s:%s", placeholder_JSON.serialize_string(it.GetKey()), it.GetValue().serialize());
			first = false;
		}
		
		s.AppendCharacter(placeholder_JSON.CURLY_CLOSE);
		return s;
	}
}
