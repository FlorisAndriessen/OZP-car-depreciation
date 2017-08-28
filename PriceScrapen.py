import urllib2
from bs4 import BeautifulSoup
#import requests as rq
import re
import time
import unicodecsv as csv
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from urlparse import urlsplit, urlunsplit

arlist= arlist= ['http://www.msn.com/en-us/autos/chevrolet/silverado-2500hd/2018/pricing/sd-AAoNTN2']

for arl in arlist:
    driver = webdriver.PhantomJS()
    driver.get(arl)
    #driver.get("http://www.msn.com/en-us/autos/ford/focus/2017/pricing/sd-AAiUWBt")
    wait = WebDriverWait(driver, 5)

    try:
        proceed = wait.until(EC.presence_of_element_located((By.LINK_TEXT, "Proceed")))
        proceed.click()
    except Exception,e:
        driver.save_screenshot('screenshot.png')


    # click proceed


    # wait for the content to be present
    #wait.until(EC.presence_of_element_located((By.ID, "workskin")))

    soup1 = BeautifulSoup(driver.page_source, "html.parser")

    #base_url = 'http://www.msn.com/en-us/autos/ford/focus/2017/pricing/sd-AAiUWBt'
    #base_url = 'http://www.msn.com/en-us/autos/bmw/3-series/2017/pricing/sd-AAiVTlg'
    #page1 = urllib2.urlopen(base_url)
    #soup1 = BeautifulSoup(page1, 'html.parser')
    print soup1
    url_list = []
    linklist = []
    url_list = soup1.find_all("div", attrs={'class': 'slider-main'})
    for url in url_list:
        for link in url.find_all('a'):
            linklist.append(link.get('href'))

    print url_list
    print linklist

    for link in linklist:
        scrape_page = 'https://www.msn.com' + link
        page2 = urllib2.urlopen(scrape_page)
        soup2 = BeautifulSoup(page2, 'html.parser')
        carslist = soup2.find_all("div", attrs={'class': 'spec-tile'})
        print len(carslist)
        for car in carslist:
      #      print(type(car))
      #      print car
            yearbrandmodel_box = soup2.find('h2', attrs={'class': 'amy-car-title'})
            print yearbrandmodel_box
            yearbrandmodel = yearbrandmodel_box.text.strip()  # strip() is used to remove starting and trailing

            price_box = car.find_all('span', attrs={'aria-hidden': 'true'})[3]
            price = price_box.text.strip()
            price = price.replace(",", "")
            price = price.replace("$", "")

            edition_box = car.find('div', attrs={'class': 'trim-title'})
            edition = edition_box.text.strip()


            print price
            print yearbrandmodel
            print edition
            with open("ScrapedPricesMileage.csv", "ab") as f:
                writer = csv.writer(f)
                writer.writerow([price, yearbrandmodel, edition])
