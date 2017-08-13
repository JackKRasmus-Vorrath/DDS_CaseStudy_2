# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

def convert_to_fahrenheit(celsius):

    temp = celsius.split()
    c = [float(i) for i in temp]
    f = [(i * 9 / 5 + 32) for i in c]
    print('The conversions from Celsius to Fahrenheit are: ', *f)


def convert_to_celsius(fahrenheit):

    temp = fahrenheit.split()
    f = [float(i) for i in temp]
    c = [((i - 32) * 5 / 9) for i in f]
    print('The conversions from Fahrenheit to Celsius are: ', *c)


def convert():
    while True:
        try:
        
            user_input = input('From what do you want to convert (C, F, or Q to quit)?: ')
        
            if user_input == 'celsius' or user_input == 'c' or user_input == 'C' or user_input == 'Celsius':
                print('To convert a temperature from Celsius to Fahrenheit:')
                celsius = input('CELSIUS as a (sequence of space-separated) number(s): ')
                convert_to_fahrenheit(celsius)
                                      
            elif user_input == 'fahrenheit' or user_input == 'f' or user_input == 'F' or user_input == 'Fahrenheit':
                print('To convert a temperature from Fahrenheit to Celsius:')
                fahrenheit = input('FAHRENHEIT as a (sequence of space-separated) number(s): ')
                convert_to_celsius(fahrenheit)
                
            elif user_input == 'q' or user_input == 'Q' or user_input == 'Quit' or user_input == 'quit':
                print('Quitting now')
                break
        
            else:
                raise ValueError
        
        except ValueError:
            print('Choose C, F, or Q. Insert temperatures as space-separated numbers.')
            continue
            
        
convert()