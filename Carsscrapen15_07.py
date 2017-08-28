import urllib2
from bs4 import BeautifulSoup
#import requests as rq
import re
import time
import csv
from urlparse import urlsplit, urlunsplit
from multiprocessing import Pool  # This is a thread-based Pool
from multiprocessing import cpu_count

linklist2 = []
start_time = time.time()
arl_list =['https://www.cars.com/for-sale/searchresults.action/?mdId=22128&mkId=20053&page=1&perPage=100&rd=99999&searchSource=SORT&sort=distance-nearest&stkTypId=28881&zc=55555']
for arl in arl_list:
    base_url = arl
    page1 = urllib2.urlopen(base_url)
    soup1 = BeautifulSoup(page1, 'html.parser')
     #Use regex to isolate only the links of the page numbers, the one you click on.
    page_count_links = soup1.find_all("a",href=re.compile(r".*javascript:goToPage.*"))
    try: # Make sure there are more than one page, otherwise, set to 1.
        num_pages = 2
    except IndexError:
       num_pages = 1

    i = 1
    # Add 1 because Python range.
    #url_list = ["{}{}".format(base_url, str(page)) for page in range(1, num_pages + 1)]
    url_list = [base_url] * num_pages
    print url_list
    new_url_list = []
    for url in url_list:
        new_url_list.append(url.replace("page=1", "page=" + str(i)))
        i = i+1
    #print url_list
    #print new_url_list
    linklist = []

    for url in new_url_list:
        print  url
        currentpage = urllib2.urlopen(url)
        currentsoup = BeautifulSoup(currentpage, 'html.parser')
        listing_list = currentsoup.find_all("h2", attrs={'class': 'cui-delta listing-row__title listing-row__title-visited'})
    #    print  listing_list
        for listing in listing_list:
            for link in listing.find_all('a'):
                linklist.append(link.get('href'))
         #   print "2"
    print linklist
    linklist2 += linklist
       # print listing_list
       # print linklist
       # print "hier"
print 'linklist2'
print linklist2
teller = 1
# PROGRAM THAT WRITES SCV FILE FROM A PAGE
def pagescraper(input):
    scrape_page = 'https://www.cars.com' + input
    print scrape_page
    # query the website and return the html to the variable 'page'
    page = urllib2.urlopen(scrape_page)
    # parse the html using beautiful soap and store in variable `soup`
    soup = BeautifulSoup(page, 'html.parser')
    print 'def wordt gerund'
    # Find list of info and get its value
    Info_list = soup.find_all('span', attrs={'class': 'list-definition__prop'})
#    print teller
    print("--- %s seconds ---" % (time.time() - start_time))
 #   teller = teller + 1
    # get relevant info from the list
    if len(Info_list)==10:
        mileage = Info_list[0].text.strip()  # strip() is used to remove starting and trailing
        color = Info_list[1].text.strip()  # strip() is used to remove starting and trailing
        interior_color = Info_list[4].text.strip()  # strip() is used to remove starting and trailing
        fuel = Info_list[5].text.strip()  # strip() is used to remove starting and trailing
        transmission = Info_list[7].text.strip()  # strip() is used to remove starting and trailing
        drivetype = Info_list[8].text.strip()  # strip() is used to remove starting and trailing
    else:
        mileage = Info_list[0].text.strip()  # strip() is used to remove starting and trailing
        color = Info_list[1].text.strip()  # strip() is used to remove starting and trailing
        interior_color = "unknown"  # strip() is used to remove starting and trailing
        fuel = Info_list[4].text.strip()  # strip() is used to remove starting and trailing
        transmission = Info_list[6].text.strip()  # strip() is used to remove starting and trailing
        drivetype = Info_list[7].text.strip()  # strip() is used to remove starting and trailing
    # print Info_list
    mileage = mileage.replace(",","")
    # get model, year, edition
    model_box = soup.find('h1', attrs={'class': 'vdp-header__title cui-delta'})
    model = model_box.text.strip()  # strip() is used to remove starting and trailing
    #  print model

    # Get seller name to see check for dealer or private seller
    # Seller_box = soup.find('h4', attrs={'class': 'cui-delta'})
    # print Seller_box
    # print "1"
    # Seller = Seller_box.text.strip() # strip() is used to remove starting and trailing
    # print Seller

    # get price
    Price_box = soup.find('strong', attrs={'class': 'vdp-header__price vdp-header__price--primary cui-beta'})
    price = Price_box.text.strip()  # strip() is used to remove starting and trailing
    price = price.replace(",", "")

    placeholer = [model, price, mileage, color, interior_color, fuel, transmission, drivetype]
    print placeholer


    with open("ScrapedcarsMileage.csv", "ab") as f:
        writer = csv.writer(f)
        writer.writerow(placeholer)
    return placeholer
    # open a csv file with append, so old data will not be erased


if __name__ == "__main__":
    fileName = "SomeSiteValidURLs.csv"
    pool = Pool(cpu_count() * 2)  # Creates a Pool with cpu_count * 2 threads.
    results = pool.map(pagescraper,linklist2)  # results is a list of all the placeHolder lists returned from each call to crawlToCSV
      #  for result in results:

