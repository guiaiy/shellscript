#!/bin/bash
cur_path=`hostname`;
title=`echo ${cur_path##/*/}`;
nameTerminal $title;
