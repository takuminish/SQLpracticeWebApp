#!/bin/bash

until mysqladmin ping -h db --silent; do
    echo 'waiting mysql'
    sleep 5
done
