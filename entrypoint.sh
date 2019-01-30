#!/bin/bash

until mysqladmin ping -h $1 --silent; do
    echo 'waiting mysql'
    sleep 5
done
