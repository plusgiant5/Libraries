local parser = {}

export type map<T> = {[T]: true}

export type position = {
	line: number;
	column: number;
}
local function format_position(position: position): string
	return "["..position.line..":"..position.column.."]"
end
local function format_location(location: location): string
	return format_position(location.beginning).."-"..format_position(location.ending)
end

local function decode_position(str: string): position
	local spl = string.split(str, ",")
	return {
		line = assert(tonumber(spl[1]));
		column = assert(tonumber(spl[2]));
	}
end
local function decode_location(str: string): location
	local spl = string.split(str, " - ")
	local location = newproxy(true)
	local location_mt = getmetatable(location)
	location_mt.__tostring = format_location
	location_mt.__index = {
		beginning = decode_position(spl[1]);
		ending = decode_position(spl[2]);
	}
	return location
end
export type location = typeof(decode_location("1,2 - 3,4"))

export type immediate_nil = {
	type: "nil";
}
export type immediate_boolean = {
	type: "boolean";
	value: boolean;
}
export type immediate_number = {
	type: "number";
	value: number; -- If you want 64 bits of accuracy, check how luau.parse produces AstExprConstantNumber
}
export type immediate_string = {
	type: "string";
	value: string;
}
export type immediate = immediate_nil | immediate_boolean | immediate_number | immediate_string

export type type_reference = {
	type: "reference";
	location: location;
	name_location: location;
	name: string;
	parameters: {type};
}
export type type_table_indexer = {
	location: location;
	index: type;
	result: type;
}
export type type_table_field = {
	location: location;
	field: string;
	result: type;
}
export type type_table = {
	type: "table";
	location: location;
	indexer: type_table_indexer?;
	fields: {type_table_field};
}
export type type_function = {
	type: "function";
	location: location;
	attributes: map<string>;
	generics: {string};
	generic_packs: {string};
	args: {type};
	arg_names: {string};
	returns: {type};
}
export type singleton_boolean = {
	type: "boolean";
	value: boolean;
}
export type singleton_string = {
	type: "string";
	value: string;
}
export type singleton = singleton_boolean | singleton_string
export type singleton_type = typeof(({}::singleton).type)
export type type_singleton = {
	type: "singleton";
	location: location;
	singleton: singleton;
}
export type type_union = {
	type: "union";
	location: location;
	types: {type};
}
export type type_intersection = {
	type: "intersection";
	location: location;
	types: {type};
}
export type type_typeof = {
	type: "typeof";
	location: location;
	expr: expr;
}
export type type = type_reference | type_table | type_function | type_union | type_intersection | type_typeof
export type type_type = typeof(({}::type).type)

export type name = {
	location: location;
	name: string;
	luau_type: type?;
}

export type stat_type_alias = {
	type: "type_alias";
	location: location;

	export: boolean;
	name: string;
	generics: {string};
	generic_packs: {string};
	luau_type: type;
}
export type stat_call = {
	type: "call";
	location: location;
	args_location: location;

	func: expr;
	args: {expr};
}
export type stat_local = {
	type: "local";
	location: location;

	names: {name};
	values: {expr};
}
export type stat_assign = {
	type: "assign";
	location: location;

	names: {expr_lvalue};
	values: {expr};
}
export type stat_compound_assign = {
	type: "compound_assign";
	location: location;

	name: expr_lvalue;
	operation: compound_binary_operation;
	value: expr;
}
export type stat_do = {
	type: "do";
	location: location;

	body: {stat};
}
export type stat_if = {
	type: "if";
	location: location;

	condition: expr;
	then_body: {stat};
	else_body: {stat}?;
	is_elseif: boolean; -- Can be ignored unless you want to reconstruct back to source code with high accuracy
}
export type stat_while = {
	type: "while";
	location: location;

	condition: expr;
	body: {stat};
}
export type stat_repeat = {
	type: "repeat";
	location: location;

	condition: expr;
	body: {stat};
}
export type stat_break = {
	type: "break";
	location: location;
}
export type stat_continue = {
	type: "continue";
	location: location;
}
export type stat_return = {
	type: "return";
	location: location;
	values: {expr};
}
export type stat_for_range = {
	type: "for_range";
	location: location;

	name: name;
	from: expr;
	to: expr;
	step: expr;
	step_specified: boolean;
	body: {stat};
}
export type stat_for_in = {
	type: "for_in";
	location: location;

	names: {name};
	values: {expr};
	body: {stat};
}
export type funcdef_local = {
	type: "local";
	name: string;
	new_variable: boolean;
}
export type funcdef_global = {
	type: "global";
	name: string;
}
export type funcdef_index = {
	type: "index";
	base: string;
	indexes: {string};
	namecall: boolean;
}
export type funcdef = funcdef_local | funcdef_global | funcdef_index
export type funcdef_type = typeof(({}::funcdef).type)
export type stat_function = {
	type: "function_definition";
	location: location;

	name: funcdef;
	func: expr_function;
}
export type stat = stat_type_alias | stat_call | stat_local | stat_assign | stat_do | stat_if | stat_while | stat_repeat | stat_break | stat_continue | stat_return | stat_for_range | stat_for_in | stat_function
export type stat_type = typeof(({}::stat).type)

export type expr_typecast = {
	type: "typecast";
	location: location;
	
	expr: expr;
	luau_type: type;
}
export type expr_varargs = {
	type: "varargs";
	location: location;
}
export type expr_call = stat_call
export type expr_brackets = {
	type: "brackets";
	location: location;
	
	expr: expr;
}
export type expr_name = {
	type: "name";
	location: location;
	
	name: name;
}
export type expr_global = {
	type: "global";
	location: location;
	
	global: string;
}
export type expr_immediate = {
	type: "immediate";
	location: location;
	
	immediate: immediate;
}
export type expr_index = {
	type: "index";
	location: location;
	
	expr: expr;
	namecall: boolean;
	index: expr | string;
}
export type unary_operation = "not" | "negate" | "length"
local unary_operation_conversion = {
	Not = "not";
	Minus = "negate";
	Len = "length";
}
export type expr_unary = {
	type: "unary";
	location: location;
	
	operation: unary_operation;
	expr: expr;
}
export type compound_binary_operation = "add" | "subtract" | "multiply" | "divide" | "floor_divide" | "modulus" | "exponentiate" | "concatenate"
export type binary_operation = compound_binary_operation | "not_equal" | "equal" | "lesser" | "lesser_equal" | "greater" | "greater_equal" | "and" | "or"
local compound_binary_operation_conversion = {
	Add = "add";
	Sub = "subtract";
	Mul = "multiply";
	Div = "divide";
	FloorDiv = "floor_divide";
	Mod = "modulus";
	Pow = "exponentiate";
	Concat = "concatenate";
}
local binary_operation_conversion = {
	Add = "add";
	Sub = "subtract";
	Mul = "multiply";
	Div = "divide";
	FloorDiv = "floor_divide";
	Mod = "modulus";
	Pow = "exponentiate";
	Concat = "concatenate";

	CompareNe = "not_equal";
	CompareEq = "equal";
	CompareLt = "lesser";
	CompareLe = "lesser_equal";
	CompareGt = "greater";
	CompareGe = "greater_equal";
	And = "and";
	Or = "or";
}
export type expr_binary = {
	type: "binary";
	location: location;
	
	left: expr;
	operation: binary_operation;
	right: expr;
}
export type table_item_type = "array_item" | "dictionary_item" | "dictionary_field"
export type table_item = {
	type: table_item_type;
	key: (expr | string)?;
	value: expr;
}
export type expr_table = {
	type: "table";
	location: location;
	
	initializers: {table_item};
}
export type expr_if_else = {
	type: "if_else";
	location: location;
	
	condition: expr;
	then_expr: expr;
	else_expr: expr;
}
export type expr_function = {
	type: "function";
	location: location;
	attributes: map<string>;
	debug_name: string;
	generics: {string};
	args: {name};
	vararg: boolean;
	returns: {type}?;
	body: {stat};
}
export type expr_string_interpolate = {
	type: "string_interpolate";
	location: location;
	-- In the order: {strings[1], exprs[1], strings[2], exprs[2], strings[3]}
	-- Empty strings will be inserted if there's an expr at the front or back
	-- Asserted: #strings == #exprs + 1
	strings: {string};
	exprs: {expr};
}
export type expr_lvalue = expr_name | expr_global | expr_index
export type expr = expr_lvalue | expr_typecast | expr_call | expr_brackets | expr_immediate | expr_unary | expr_binary | expr_table | expr_if_else | expr_function | expr_string_interpolate
export type expr_type = typeof(({}::expr).type)

export type obj = stat | expr
export type obj_type = typeof(({}::obj).type)

local function unexpected(obj: luau_parser_ast_obj)
	error(`Did not expect {obj.type}.`)
end

local decode_obj: (obj: luau_parser_ast_obj) -> obj
local decode_stat: (stat: luau_parser_ast_obj) -> stat
local decode_expr: (expr: luau_parser_ast_obj) -> expr
local decode_type: (type: luau_parser_ast_obj) -> type
local function decode_stats(stats: {luau_parser_ast_obj}): {stat}
	local stats_len = #stats
	local new_stats = table.create(stats_len)
	for i = 1, stats_len do
		new_stats[i] = decode_stat(stats[i])
	end
	return new_stats
end
local function decode_exprs(exprs: {luau_parser_ast_obj}): {expr}
	local exprs_len = #exprs
	local new_exprs = table.create(exprs_len)
	for i = 1, exprs_len do
		new_exprs[i] = decode_expr(exprs[i])
	end
	return new_exprs
end
local function decode_types(types: {luau_parser_ast_obj}): {type}
	local types_len = #types
	local new_types = table.create(types_len)
	for i = 1, types_len do
		new_types[i] = decode_type(types[i])
	end
	return new_types
end
local function decode_name(AstLocal: luau_parser_ast_obj): name
	assert(AstLocal.type == "AstLocal")
	return {
		location = decode_location(AstLocal.location);
		name = AstLocal.name;
		luau_type = AstLocal.luauType and decode_type(AstLocal.luauType);
	}
end
local function decode_names(names: {luau_parser_ast_obj}): {name}
	local names_len = #names
	local new_names = table.create(names_len)
	for i = 1, names_len do
		new_names[i] = decode_name(names[i])
	end
	return new_names
end
local function decode_generics(generics: {any})
	local new_generics = {}
	for _, generic in generics do
		assert(generic.type == "AstGenericType")
		table.insert(new_generics, generic.name)
	end
	return new_generics
end
local function decode_generic_packs(generic_packs: {any})
	local new_generic_packs = {}
	for _, generic_pack in generic_packs do
		assert(generic_pack.type == "AstGenericTypePack")
		table.insert(new_generic_packs, generic_pack.name)
	end
	return new_generic_packs
end
local type_case = {
	AstTypeReference = function(luau_type: luau_parser_ast_obj): type_reference
		return {
			type = "reference";
			location = decode_location(luau_type.location);
			name_location = decode_location(luau_type.nameLocation);
			name = luau_type.name;
			parameters = decode_types(luau_type.parameters);
		}
	end;
	AstTypeTable = function(luau_type: luau_parser_ast_obj): type_table
		local indexer: type_table_indexer?
		if luau_type.indexer then
			indexer = {
				location = decode_location(luau_type.indexer.location);
				index = decode_type(luau_type.indexer.indexType);
				result = decode_type(luau_type.indexer.resultType);
			}
		end
		local fields: {type_table_field} = {}
		for _, prop: luau_parser_ast_obj in luau_type.props do
			table.insert(fields, {
				location = decode_location(prop.location);
				field = prop.name;
				result = decode_type(prop.propType);
			})
		end
		return {
			type = "table";
			location = decode_location(luau_type.location);
			indexer = indexer;
			fields = fields;
		}
	end;
	AstTypeFunction = function(luau_type: luau_parser_ast_obj): type_function
		local attributes: map<string> = {}
		for _, attribute in luau_type.attributes do
			assert(attribute)
			attributes[attribute.name] = true
		end
		assert(luau_type.argTypes.type == "AstTypeList")
		local arg_names = {}
		for i, AstArgumentName in luau_type.argNames do
			assert(AstArgumentName.type == "AstArgumentName")
			arg_names[i] = AstArgumentName.name
		end
		assert(luau_type.returnTypes.type == "AstTypeList")
		return {
			type = "function";
			location = decode_location(luau_type.location);
			attributes = attributes;
			generics = decode_generics(luau_type.generics);
			generic_packs = decode_generic_packs(luau_type.genericPacks);
			args = decode_types(luau_type.argTypes.types);
			arg_names = arg_names;
			returns = decode_types(luau_type.returnTypes.types);
		}
	end;
	AstTypeSingletonBool = function(luau_type: luau_parser_ast_obj): type_singleton
		return {
			type = "singleton";
			location = decode_location(luau_type.location);
			singleton = {
				type = "boolean";
				value = luau_type.value;
			};
		}
	end;
	AstTypeSingletonString = function(luau_type: luau_parser_ast_obj): type_singleton
		return {
			type = "singleton";
			location = decode_location(luau_type.location);
			singleton = {
				type = "string";
				value = luau_type.value;
			};
		}
	end;
	AstTypeUnion = function(luau_type: luau_parser_ast_obj): type_union
		return {
			type = "union";
			location = decode_location(luau_type.location);
			types = decode_types(luau_type.types);
		}
	end;
	AstTypeIntersection = function(luau_type: luau_parser_ast_obj): type_intersection
		return {
			type = "intersection";
			location = decode_location(luau_type.location);
			types = decode_types(luau_type.types);
		}
	end;
	AstTypeTypeof = function(luau_type: luau_parser_ast_obj): type_typeof
		return {
			type = "typeof";
			location = decode_location(luau_type.location);
			expr = decode_expr(luau_type.expr);
		}
	end;
}
function decode_type(luau_type: luau_parser_ast_obj): type
	local case = type_case[luau_type.type]
	if case then
		return case(luau_type)
	else
		print(luau_type)
		error(`Unexpected luau_type type "{luau_type.type}"`)
	end
end
local stat_case = {
	AstStatBlock = function(stat: luau_parser_ast_obj): stat_do
		return {
			type = "do";
			location = decode_location(stat.location);
			body = decode_stats(stat.body);
		}
	end;
	AstStatExpr = function(stat: luau_parser_ast_obj): stat_call
		local expr = stat.expr
		assert(expr.type == "AstExprCall")
		return decode_expr(expr)::expr_call
	end;
	AstStatTypeAlias = function(stat: luau_parser_ast_obj): stat_type_alias
		return {
			type = "type_alias";
			location = decode_location(stat.location);
			export = stat.exported;
			name = stat.name;
			generics = decode_generics(stat.generics);
			generic_packs = decode_generic_packs(stat.genericPacks);
			luau_type = decode_type(stat.value);
		}
	end;
	AstStatLocal = function(stat: luau_parser_ast_obj): stat_local
		return {
			type = "local";
			location = decode_location(stat.location);
			names = decode_names(stat.vars);
			values = decode_exprs(stat.values);
		}
	end;
	AstStatAssign = function(stat: luau_parser_ast_obj): stat_assign
		local names = {}
		for _, name in stat.vars do
			local expr = decode_expr(name)
			assert(expr.type == "name" or expr.type == "global" or expr.type == "index")
			table.insert(names, expr)
		end
		return {
			type = "assign";
			location = decode_location(stat.location);
			names = names;
			values = decode_exprs(stat.values);
		}
	end;
	AstStatCompoundAssign = function(stat: luau_parser_ast_obj): stat_compound_assign
		local name = decode_expr(stat.var)
		assert(name.type == "name" or name.type == "global" or name.type == "index")
		return {
			type = "compound_assign";
			location = decode_location(stat.location);
			name = name;
			operation = assert(compound_binary_operation_conversion[stat.op]);
			value = decode_expr(stat.value);
		}
	end;
	AstStatIf = function(stat: luau_parser_ast_obj): stat_if
		local else_body
		local is_elseif = false
		if stat.elsebody then
			if stat.elsebody.type == "AstStatIf" then
				else_body = {decode_stat(stat.elsebody)}
				is_elseif = true
			else
				assert(stat.elsebody.type == "AstStatBlock")
				else_body = decode_stats(stat.elsebody.body)
			end
		end
		assert(stat.thenbody.type == "AstStatBlock")
		return {
			type = "if";
			location = decode_location(stat.location);
			condition = decode_expr(stat.condition);
			then_body = decode_stats(stat.thenbody.body);
			else_body = else_body;
			is_elseif = is_elseif;
		}
	end;
	AstStatWhile = function(stat: luau_parser_ast_obj): stat_while
		assert(stat.body.type == "AstStatBlock")
		return {
			type = "while";
			location = decode_location(stat.location);
			condition = decode_expr(stat.condition);
			body = decode_stats(stat.body.body);
		}
	end;
	AstStatRepeat = function(stat: luau_parser_ast_obj): stat_repeat
		assert(stat.body.type == "AstStatBlock")
		return {
			type = "repeat";
			location = decode_location(stat.location);
			condition = decode_expr(stat.condition);
			body = decode_stats(stat.body.body);
		}
	end;
	AstStatBreak = function(stat: luau_parser_ast_obj): stat_break
		return {
			type = "break";
			location = decode_location(stat.location);
		}
	end;
	AstStatContinue = function(stat: luau_parser_ast_obj): stat_continue
		return {
			type = "continue";
			location = decode_location(stat.location);
		}
	end;
	AstStatReturn = function(stat: luau_parser_ast_obj): stat_return
		return {
			type = "return";
			location = decode_location(stat.location);
			values = decode_exprs(stat.list)
		}
	end;
	AstStatFor = function(stat: luau_parser_ast_obj): stat_for_range
		local step
		local step_specified = false
		if stat.step then
			step = decode_expr(stat.step)
			step_specified = true
		else
			step = {
				type = "immediate";
				location = {beginning = {line = 0; column = 0}; ending = {line = 0; column = 0}};
				immediate = {
					type = "number";
					value = 1;
				};
			}
		end
		assert(stat.body.type == "AstStatBlock")
		return {
			type = "for_range";
			location = decode_location(stat.location);
			name = decode_name(stat.var);
			from = decode_expr(stat.from);
			to = decode_expr(stat.to);
			step = step;
			step_specified = step_specified;
			body = decode_stats(stat.body.body);
		}
	end;
	AstStatForIn = function(stat: luau_parser_ast_obj): stat_for_in
		assert(stat.body.type == "AstStatBlock")
		return {
			type = "for_in";
			location = decode_location(stat.location);
			names = decode_names(stat.vars);
			values = decode_exprs(stat.values);
			body = decode_stats(stat.body.body);
		}
	end;
	AstStatFunction = function(stat: luau_parser_ast_obj): stat_function
		local funcdef: funcdef
		local current_name: luau_parser_ast_obj = stat.name
		if current_name.type == "AstExprGlobal" then
			funcdef = {
				type = "global";
				name = current_name.global;
			}
		elseif current_name.type == "AstExprLocal" then
			assert(current_name["local"].type == "AstLocal")
			funcdef = {
				type = "local";
				name = current_name["local"].name;
				new_variable = false;
			}
		elseif current_name.type == "AstLocal" then
			funcdef = {
				type = "local";
				name = current_name.name;
				new_variable = true;
			}
		elseif current_name.type == "AstExprIndexName" then
			local namecall = false
			local indexes = {}
			repeat
				table.insert(indexes, current_name.index)
				if current_name.op == ":" then
					namecall = true
				end
				current_name = current_name.expr
			until current_name.type ~= "AstExprIndexName"
			local base
			local last_type = current_name.type
			if last_type == "AstExprGlobal" then
				base = current_name.global
			elseif last_type == "AstExprLocal" then
				base = current_name.name
			else
				error(`Unexpected type "{current_name.type}" in function name at bottom of index chain`)
			end
			funcdef = {
				type = "index";
				base = base;
				indexes = indexes;
				namecall = namecall;
			}
		else
			error(`Unexpected type "{current_name.type}" in function name`)
		end
		assert(stat.func.type == "AstExprFunction")
		local func = decode_expr(stat.func)
		assert(func.type == "function")
		return {
			type = "function_definition";
			location = decode_location(stat.location);
			name = funcdef;
			func = func;
		}
	end;
}
stat_case.AstStatLocalFunction = stat_case.AstStatFunction
function decode_stat(stat: luau_parser_ast_obj): stat
	local case = stat_case[stat.type]
	if case then
		return case(stat)
	else
		print(stat)
		error(`Unexpected stat type "{stat.type}"`)
	end
end
local expr_case = {
	AstExprTypeAssertion = function(expr: luau_parser_ast_obj): expr_typecast
		return {
			type = "typecast";
			location = decode_location(expr.location);
			expr = decode_expr(expr.expr);
			luau_type = decode_type(expr.annotation);
		}
	end;
	AstExprVarargs = function(expr: luau_parser_ast_obj): expr_varargs
		return {
			type = "varargs";
			location = decode_location(expr.location);
		}
	end;
	AstExprGroup = function(expr: luau_parser_ast_obj): expr_brackets
		return {
			type = "brackets";
			location = decode_location(expr.location);
			expr = decode_expr(expr.expr);
		}
	end;
	AstExprLocal = function(expr: luau_parser_ast_obj): expr_name
		return {
			type = "name";
			location = decode_location(expr.location);
			name = decode_name(expr["local"]);
		}
	end;
	AstExprGlobal = function(expr: luau_parser_ast_obj): expr_global
		return {
			type = "global";
			location = decode_location(expr.location);
			global = expr.global;
		}
	end;
	AstExprCall = function(expr: luau_parser_ast_obj): expr_call
		return {
			type = "call";
			location = decode_location(expr.location);
			args_location = decode_location(expr.argLocation);
			func = decode_expr(expr.func);
			args = decode_exprs(expr.args);
		}
	end;
	AstExprConstantNumber = function(expr: luau_parser_ast_obj): expr_immediate
		return {
			type = "immediate";
			location = decode_location(expr.location);
			immediate = {
				type = "number";
				value = assert(tonumber(expr.value));
			};
		}
	end;
	AstExprConstantNil = function(expr: luau_parser_ast_obj): expr_immediate
		return {
			type = "immediate";
			location = decode_location(expr.location);
			immediate = {
				type = "nil";
			};
		}
	end;
	AstExprConstantBool = function(expr: luau_parser_ast_obj): expr_immediate
		return {
			type = "immediate";
			location = decode_location(expr.location);
			immediate = {
				type = "boolean";
				value = expr.value;
			};
		}
	end;
	AstExprConstantString = function(expr: luau_parser_ast_obj): expr_immediate
		return {
			type = "immediate";
			location = decode_location(expr.location);
			immediate = {
				type = "string";
				value = expr.value;
			};
		}
	end;
	AstExprIndexName = function(expr: luau_parser_ast_obj): expr_index
		return {
			type = "index";
			location = decode_location(expr.location);
			expr = decode_expr(expr.expr);
			namecall = expr.op == ":";
			index = expr.index;
		}
	end;
	AstExprIndexExpr = function(expr: luau_parser_ast_obj): expr_index
		return {
			type = "index";
			location = decode_location(expr.location);
			expr = decode_expr(expr.expr);
			namecall = false;
			index = decode_expr(expr.index);
		}
	end;
	AstExprUnary = function(expr: luau_parser_ast_obj): expr_unary
		return {
			type = "unary";
			location = decode_location(expr.location);
			operation = assert(unary_operation_conversion[expr.op]);
			expr = decode_expr(expr.expr);
		}
	end;
	AstExprBinary = function(expr: luau_parser_ast_obj): expr_binary
		return {
			type = "binary";
			location = decode_location(expr.location);
			left = decode_expr(expr.left);
			operation = assert(binary_operation_conversion[expr.op]);
			right = decode_expr(expr.right);
		}
	end;
	AstExprTable = function(expr: luau_parser_ast_obj): expr_table
		local initializers: {table_item} = {}
		for _, item in expr.items do
			assert(item.type == "AstExprTableItem")
			if item.kind == "item" then
				table.insert(initializers, {
					type = "array_item";
					value = decode_expr(item.value);
				})
			elseif item.kind == "general" then
				table.insert(initializers, {
					type = "dictionary_item";
					key = decode_expr(item.key);
					value = decode_expr(item.value);
				})
			elseif item.kind == "record" then
				assert(item.key)
				assert(item.key.type == "AstExprConstantString")
				table.insert(initializers, {
					type = "dictionary_field";
					key = item.key.value;
					value = decode_expr(item.value);
				})
			else
				error(`Unknown initializer item kind "{item.kind}"`)
			end
		end
		return {
			type = "table";
			location = decode_location(expr.location);
			initializers = initializers;
		}
	end;
	AstExprIfElse = function(expr: luau_parser_ast_obj): expr_if_else
		return {
			type = "if_else";
			location = decode_location(expr.location);
			condition = decode_expr(expr.condition);
			then_expr = decode_expr(expr.trueExpr);
			else_expr = decode_expr(expr.falseExpr);
		}
	end;
	AstExprFunction = function(expr: luau_parser_ast_obj): expr_function
		local attributes: map<string> = {}
		for _, attribute in expr.attributes do
			assert(attribute)
			attributes[attribute.name] = true
		end
		local returns
		if expr.returnAnnotation then
			assert(expr.returnAnnotation.type == "AstTypeList")
			returns = decode_types(expr.returnAnnotation.types)
		end
		assert(expr.body.type == "AstStatBlock")
		return {
			type = "function";
			location = decode_location(expr.location);
			attributes = attributes;
			debug_name = expr.debugname;
			generics = decode_generics(expr.generics);
			generic_packs = decode_generic_packs(expr.genericPacks);
			args = decode_names(expr.args);
			returns = returns;
			vararg = expr.vararg;
			body = decode_stats(expr.body.body)
		}
	end;
	AstExprInterpString = function(expr: luau_parser_ast_obj): expr_string_interpolate
		local strings = expr.strings
		local exprs = decode_exprs(expr.expressions)
		assert(#strings == #exprs + 1)
		return {
			type = "string_interpolate";
			location = decode_location(expr.location);
			strings = strings;
			exprs = exprs;
		}
	end;
}
function decode_expr(expr: luau_parser_ast_obj): expr
	local case = expr_case[expr.type]
	if case then
		return case(expr)
	else
		print(expr)
		error(`Unexpected expr type "{expr.type}"`)
	end
end
function decode_obj(obj: luau_parser_ast_obj): obj
	local base_type = string.sub(obj.type, 1, 7)
	if base_type == "AstStat" then
		return decode_stat(obj)
	else
		assert(base_type == "AstExpr", obj.type)
		return decode_expr(obj)
	end
end

export type error = {
	what: string;
	location: location;
}
export type parse_result = {
	ast: {stat};
	errors: {error};
}

function parser.parse(source: string): parse_result
	local raw_result = luau.parse(source)
	local errors: {error} = {}
	for _, error in raw_result.errors do
		table.insert(errors, {
			what = error.message;
			location = decode_location(error.location);
		})
	end
	local ast
	if #errors == 0 then
		ast = decode_stats(raw_result.ast.root.body)
	else
		ast = {}
	end
	
	return {
		ast = ast;
		errors = errors;
	}
end

return parser
