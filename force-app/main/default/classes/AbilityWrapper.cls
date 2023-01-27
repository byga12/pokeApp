public class AbilityWrapper{
	public List<cls_effect_entries> effect_entries;
	public Integer id;
	public String name;
	public List<cls_pokemon> pokemon;
    
	public class cls_effect_entries {
		public cls_language language;
		public String short_effect;
	}
	public class cls_language {
		public String name;
	}
	public class cls_pokemon {
		public cls2_pokemon pokemon;
	}
    public class cls2_pokemon {
        public String name;
        public String url;  
    }
	public static AbilityWrapper parse(String json){
		return (AbilityWrapper) System.JSON.deserialize(json, AbilityWrapper.class);
	}
	
}