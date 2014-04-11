<?php

##################################################
#
# Copyright (c) 2004-2014 OIC Group, Inc.
#
# This file is part of Exponent
#
# Exponent is free software; you can redistribute
# it and/or modify it under the terms of the GNU
# General Public License as published by the Free
# Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# GPL: http://www.gnu.org/licenses/gpl.txt
#
##################################################

/**
 * Smarty plugin
 * @package Smarty-Plugins
 * @subpackage Compiler
 */

/**
 * Smarty {exp_include} compiler plugin
 *
 * Author: Liu Song - loosen.copen@gmail.com
 * File: compiler.include_if_exists.php
 * Type: compiler
 * Name: include_if_exists
 * Version: 1.0.0 
 * Source: http://code.google.com/p/smartyplugin-include-if-exists/downloads/list
 * Purpose: Similar with "include" function, but only include the
 *	template file when it exists. Otherwise, a default file passed
 *	by parameter "else" will be included.
 *
 * Updates
 *    Version 2.0:
 *       Updated to work with Smarty v3 and added Exponent framework template detection/selection
 *
 * Example:
 *	1	{exp_include file="foo" assign="foo"}
 *	2	{exp_include file="foo" else="default"}
 */

/**
 * Smarty {exp_include} compiler plugin
 * Type:     compiler<br>
 * Name:     exp_include<br>
 * Purpose:  includes appropriate file based on 'framework' with fallback
 *
 * @param $_params
 * @param $compiler
 *
 * @return string
 */
function smarty_compiler_exp_include($_params, &$compiler) {
	$arg_list = array();
	if(!isset($_params['file'])) {
		trigger_error("missing 'file' attribute in exp_include tag in " . __FILE__ . " on line " . __LINE__, E_COMPILE_WARNING);
		return;
	}
	foreach($_params as $arg_name => $arg_value) {
        // look for specific arguments: file, else, or assign
		if($arg_name == 'file') {
			$include_file = str_replace(array('\'', '"'), '', $arg_value); ;
            $path = substr(str_replace(PATH_RELATIVE, '', $compiler->tpl_vars['asset_path']->value), 0, -7) . 'views/' . $compiler->tpl_vars['modelname']->value . '/';  // strip relative path for links coming from templates
            // store/strip template file type
            $fileparts = explode('.', $include_file);
            if (count($fileparts) > 1) {
                $type = array_pop($fileparts);
            } else $type = '.tpl';
            $include_file = implode($fileparts);
            // see if there's an framework appropriate template variation
            $framework =  expSession::get('framework');
            if ($framework == 'bootstrap' || $framework == 'bootstrap3') {
                if (file_exists(BASE . $path . $include_file . '.bootstrap.' . $type)) {
                    $include_file = $include_file . '.bootstrap.' . $type;
                } elseif ($framework == 'bootstrap3' && file_exists(BASE . $path . $include_file . '.bootstrap3.' . $type)) {
                    $include_file = $include_file . '.bootstrap3.' . $type;
                } else {
                    $include_file = $include_file . '.' . $type;
                }
            } else {
                if (NEWUI) {
                    if (file_exists(BASE . $path . $include_file . '.newui.' . $type)) {
                        $include_file = $include_file . '.newui.' . $type;
                    } else {
                        $include_file = $include_file . '.' . $type;
                    }
                } else {
                    $include_file = $include_file . '.' . $type;
                }
            }
            $include_file = '"' . $include_file . '"';
			continue;
		} else if($arg_name == 'else') {
			$include_file_else = $arg_value;
            // tack on a default file type if one is missing
            $fileparts = explode('.', $include_file_else);
            if (count($fileparts) == 1) {
                $include_file_else .= '.tpl';
            }
			continue;
		} else if($arg_name == 'assign') {
			$assign_var = $arg_value;
			continue;
		}
        // all other arguments are (additional) variables to pass to template
		if(is_bool($arg_value)) {
			$arg_value = $arg_value ? 'true' : 'false';
		}
		$arg_list[] = "'$arg_name' => $arg_value";
	}

	if($include_file_else) {
		$output = "\n<?php \$_include_file = (\$_smarty_tpl->templateExists({$include_file})) ? {$include_file} : {$include_file_else};\n";
	} else {
		$output = "\n<?php if(\$_smarty_tpl->templateExists({$include_file})) {\n";
	}

	if(isset($assign_var)) {
		$output .= "ob_start();\n";
	}

	$output .= "\$_smarty_tpl_vars = \$_smarty_tpl->tpl_vars;\n";
	
	if($include_file_else) {
        $output .= "echo \$_smarty_tpl->getSubTemplate(\$_include_file, \$_smarty_tpl->cache_id, \$_smarty_tpl->compile_id, 0, null, array(".implode(',', (array)$arg_list)."), 0);\n";
	} else {
        $output .= "echo \$_smarty_tpl->getSubTemplate({$include_file}, \$_smarty_tpl->cache_id, \$_smarty_tpl->compile_id, 0, null, array(".implode(',', (array)$arg_list)."), 0);\n";
	}
	$output .= "\$_smarty_tpl->tpl_vars = \$_smarty_tpl_vars;\n" .
		"unset(\$_smarty_tpl_vars);\n";

	if(isset($assign_var)) {
		$output .= "\$_smarty_tpl->assign(" . $assign_var . ", ob_get_contents()); ob_end_clean();\n";
	}

	if($include_file_else) {
		$output .= "unset(\$_include_file); ?>\n";
	} else {
		$output .= "} ?>\n";
	}

	return $output;
}
?>