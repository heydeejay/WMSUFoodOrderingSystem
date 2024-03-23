from flask import Flask,Blueprint, render_template, request, flash, redirect, url_for, jsonify,send_from_directory, make_response, session
from flask_login import login_required, current_user
from .models import *
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import login_user, login_required, logout_user, current_user
from sqlalchemy import delete, desc, asc
from sqlalchemy import delete
from sqlalchemy import select
import json
from os import path
import os
from io import TextIOWrapper
import csv
import io
import random
import base64
import datetime
from datetime import datetime, date,timedelta




USER_CONTENT_FOLDER = 'usercont'
if not os.path.exists(USER_CONTENT_FOLDER):
    os.path.makedirs(USER_CONTENT_FOLDER)
    print("User content folder generated.")


_route_errand = Blueprint('_route_errand', __name__)

flask_app = Flask(__name__) #Initialize flask_app

@_route_errand.route('/errand_page')
def errand_page():

    user_id = request.args.get('user_id')
    
    errand=User.query.filter_by(id=user_id).first()

    deliveries = Delivery.query.filter(Delivery.response == 'Pending',Delivery.errand_id==0).with_entities(Delivery.track_no).count()
    track=''
    
    track = Delivery.query.filter(Delivery.mop=="COD",Delivery.errand_id==0,Delivery.response == 'Accepted').with_entities(Delivery.track_no).distinct().all()
    track1 = Delivery.query.filter(Delivery.mop=="COD",Delivery.errand_id==0,Delivery.response == 'Accepted').with_entities(Delivery.track_no).distinct().count()

    return render_template("Errand/errand_page.html",track=track,errand=errand,track1=track1)

@_route_errand.route('/errand_dashboard',methods=['POST','GET'])
def errand_dashboard():

    errand=User.query.filter_by(id=request.form['errand_id']).first()

    deliveries = Delivery.query.filter(Delivery.response == 'Accepted',Delivery.errand_id==0).with_entities(Delivery.track_no, Delivery.response).count()
    track=''
    track1 = Delivery.query.filter(Delivery.mop=="COD",Delivery.errand_id==0,Delivery.response == 'Accepted').with_entities(Delivery.track_no).distinct().count()

    
    track = Delivery.query.filter(Delivery.mop=="COD",Delivery.errand_id==0,Delivery.response == 'Accepted').with_entities(Delivery.track_no).distinct().all()

    return render_template("Errand/errand_page.html",track=track,track1=track1,errand=errand)


@_route_errand.route('/errand_view_details',methods=['POST','GET'])
def errand_view_details():
    errand=User.query.filter_by(id=request.form['errand_id']).first()
    order = Delivery.query.filter(Delivery.track_no == request.form['track_no'], Delivery.response=='Accepted').all()
    for order1 in order:
        order1.errand_id=request.form['errand_id']
    db.session.commit()
    track1 = Delivery.query.with_entities(Delivery.track_no).filter(Delivery.mop=="COD",Delivery.errand_id==0).distinct().count()

    return render_template("Errand/errand_view_details.html",order=order, track1=track1,track=request.form['track_no'],errand=errand)

@_route_errand.route('/errand_food_ready',methods=['POST','GET'])
def errand_food_ready():
    errand=User.query.filter_by(id=request.form['errand_id']).first()
    track = Delivery.query.filter(Delivery.track_no == request.form['track']).first()
    customer = User.query.filter(User.id == track.customer_id).first()
    tracks=Delivery.query.filter(Delivery.track_no == request.form['track']).all()
    records_to_update = Delivery.query.filter(Delivery.customer_id == customer.id).all()

    for record in records_to_update:
        record.food_ready = 'yes'
    
    # After making changes, commit the updates to the database.
    db.session.commit()
    track1 = Delivery.query.with_entities(Delivery.track_no).filter(Delivery.mop=="COD",Delivery.errand_id==0).distinct().count()

    return render_template("Errand/errand_food_ready.html",customer=customer,track=track,errand=errand,track1=track1,tracks=tracks)

@_route_errand.route('/errand_remittance',methods=['POST','GET'])
def errand_remittance():

    errand=User.query.filter_by(id=request.form['errand_id']).first()
    track = Delivery.query.filter(Delivery.track_no == request.form['track']).first()
    orderlist = Delivery.query.filter(Delivery.track_no == request.form['track'], Delivery.response=='Accepted').all()
    total_sum = sum(order.total for order in orderlist)
    
    fee = Delivery.query.filter(Delivery.track_no == request.form['track']).with_entities(Delivery.vendor).distinct().count()
    if fee>1:
        fee1=Fee.query.first()
        fee=(fee1.additional*fee)-fee1.additional
        
        df=fee1.fees + fee
        total_sum=total_sum + fee1.fees + fee

    else: 
        fee1=Fee.query.first()
        df=fee1.fees
        total_sum=fee1.fees + total_sum
    
    customer = User.query.filter(User.id == track.customer_id).first()

    for orderlist1 in orderlist:
            orderlist1.payment = 'yes'
    # After making changes, commit the updates to the database.
    db.session.commit()  
    track1 = Delivery.query.with_entities(Delivery.track_no).filter(Delivery.mop=="COD",Delivery.errand_id==0).distinct().count()
    print(fee)
    msg='payment_ready'
    return render_template("Errand/errand_remittance.html",track1=track1,track=track,total_sum=total_sum,customer=customer,errand=errand,df=df,msg=msg)

@_route_errand.route('/errand_sales',methods=['POST','GET'])
def errand_sales():
    
    
    errand=User.query.filter_by(id=request.form['errand_id']).first()
    sale = Errand_sales.query.filter(Errand_sales.errand == errand.id).with_entities(Errand_sales.track_no, Errand_sales.total,Errand_sales.mop).distinct().all()
    
    total_sum = sum(order.total for order in sale)
    track1 = Delivery.query.with_entities(Delivery.track_no).filter(Delivery.mop=="COD",Delivery.errand_id==0).distinct().count()

    return render_template("Errand/errand_sales.html",track1=track1,errand=errand,sale=sale,total_sum=total_sum)

@_route_errand.route('/errand_remittance_cut',methods=['POST','GET'])
def errand_remittance_cut():
    
    try:
        errand=User.query.filter_by(id=request.form['errand_id']).first()
        track = Delivery.query.filter(Delivery.errand_id == errand.id).first()
        orderlist = Delivery.query.filter(Delivery.errand_id == errand.id, Delivery.response=='Accepted').all()
        total_sum = sum(order.total for order in orderlist)
        
        fee = Delivery.query.filter(Delivery.errand_id == errand.id).with_entities(Delivery.vendor).distinct().count()
        if fee>1:
            fee1=Fee.query.first()
            fee=(fee1.additional*fee)-fee1.additional
            
            total_sum=total_sum + fee1.fees + fee
            
            
        else: 
            fee1=Fee.query.first()
            fee=fee1.fees
            total_sum=fee1.fees + total_sum
            
        customer = User.query.filter(User.id == track.customer_id).first()
        fe=Fee.query.first()
        
        track1 = Delivery.query.with_entities(Delivery.track_no).filter(Delivery.mop=="COD",Delivery.errand_id==0).distinct().count()
        msg='payment_ready'
        return render_template("Errand/errand_remittance.html",track1=track1,track=track,total_sum=total_sum,customer=customer,errand=errand,fee=fee,msg=msg)
    
    except:
        date = datetime.now()
        search=User.query.filter_by(first_name="No Record",last_name="No Record",middle_name="No Record").count()

        if search== 0:
            new_user = User("No Record", "No Record", "No Record","No Record","No Record","No Record", "No Record", 5, "No Record",None, 0,0,date)
            new_del = Delivery("No Record",0,0,0,"No Record","No Record",0,0,0,"No Record","No Record","No Record","No Record","No Record",0,0,date)
            db.session.add(new_user)
            db.session.add(new_del)
            db.session.commit()
        
        
        track = Delivery.query.filter(Delivery.food_name == "No Record").first()
        orderlist = Delivery.query.filter(Delivery.response=='No Record').all()
        total_sum = sum(order.total for order in orderlist)

        for orderlist1 in orderlist:
            orderlist1.payment = 'yes'
        # After making changes, commit the updates to the database.
        db.session.commit()
        customer = User.query.filter(User.first_name == "No Record").first()
        
        track1 = Delivery.query.with_entities(Delivery.track_no).filter(Delivery.mop=="COD",Delivery.errand_id==0).distinct().count()

        return render_template("Errand/errand_remittance.html",track1=track1,track=track,total_sum=total_sum,customer=customer,errand=errand)
    

@_route_errand.route('/errand_transaction',methods=['POST','GET'])
def errand_transaction():
    errand=User.query.filter_by(id=request.form['errand_id']).first()

    return render_template("Errand/errand_transaction.html",errand=errand)


@_route_errand.route('/errand_remittance_1',methods=['POST','GET'])
def errand_remittance_1():
    errand=User.query.filter_by(id=request.form['errand_id']).first()
    track = Delivery.query.filter(Delivery.track_no == request.form['track']).first()
    orderlist = Delivery.query.filter(Delivery.track_no == request.form['track'], Delivery.response=='Accepted').all()
    total_sum = sum(order.total for order in orderlist)
    fe=Fee.query.first()
    total_sum=fe.fees + total_sum
    customer = User.query.filter(User.id == track.customer_id).first()

    return render_template("Errand/errand_remittance.html",track=track,total_sum=total_sum,customer=customer,errand=errand)


@_route_errand.route('/remit',methods=['POST','GET'])
def remit():
    
    track = Delivery.query.filter(Delivery.track_no == request.form['track_no']).first()
    errand=User.query.filter_by(id=request.form['errand_id']).first()
    payment=request.form['payment'] #gcash or cash
    
    orderlist = Delivery.query.filter(Delivery.track_no == request.form['track_no'], Delivery.response=='Accepted').all()
    total_sum = sum(order.total for order in orderlist)

    refereance=request.form['ref_no']
    if payment== "cash":
        refereance= "None"

    date = datetime.now()
    # Query to get unique vendors and their total sum for the given track number
    vendors_and_sums = db.session.query(Delivery.vendor, db.func.sum(Delivery.total).label('total_sum')).filter(Delivery.track_no == request.form['track_no']).group_by(Delivery.vendor).all()

    # Iterate over each vendor and total sum, and create a Remittance object
    for vendor_and_sum in vendors_and_sums:
        vendor = vendor_and_sum.vendor
        total_sum = vendor_and_sum.total_sum
        
        remit = Remittance(track.track_no, vendor, total_sum, track.mop, request.form['payment'], refereance, errand.first_name,request.form['delivery_fee'], date)

        # Add the Remittance object to the database session
        db.session.add(remit)

    # Commit all changes to the database
    
    db.session.commit()
    
    check=Remittance.query.filter(Remittance.track_no==request.form['track_no']).count()
    if check==0:
        msg=''
        remit=Remittance.query.filter(Remittance.track_no==0).count()
        if remit==0:
            date = datetime.now()
            new_del = Delivery(0,"No Record",0,"No Record","No Record",0, "No Record",date)
            db.session.add(new_del)
            db.session.commit()
        remits=Remittance.query.filter(Remittance.track_no==0).all()
            
    else: 
        remits=Remittance.query.filter(Remittance.track_no==request.form['track_no']).all()
        msg='remitted'
        
    track = Delivery.query.filter(Delivery.food_name == "No Record").first()
    orderlist = Delivery.query.filter(Delivery.response=='No Record').all()
    total_sum = sum(order.total for order in orderlist)

    for orderlist1 in orderlist:
        orderlist1.payment = 'yes'
    # After making changes, commit the updates to the database.
    db.session.commit()
    customer = User.query.filter(User.first_name == "No Record").first()
    
    track1 = Delivery.query.with_entities(Delivery.track_no).filter(Delivery.mop=="COD",Delivery.errand_id==0).distinct().count()

    return render_template("Errand/errand_remittance.html",errand=errand,remits=remits,msg=msg,track1=track1,track=track,total_sum=total_sum,customer=customer)

@_route_errand.route('/errand_profile',methods=['POST','GET'])
def errand_profile():
    errand=User.query.filter_by(id=request.form['errand_id']).first()
   
    return render_template("Errand/errand_profile.html",errand=errand)


@_route_errand.route('/errand_profile_update',  methods=['POST','GET'])
def vendor_profile_edit():
        errand=User.query.filter_by(id=request.form['errand_id']).first()
        
        fname = None
        if 'file' in request.files:
            fname = handle_profile_submition(request.files['file'])
            if fname is None:
                print("error")
       
        errand.first_name=request.form['first_name']
        errand.last_name=request.form['last_name']
        errand.middle_name=request.form['middle_name']
        errand.contact=request.form['contact']
        errand.email=request.form['email']
        errand.password=generate_password_hash(request.form['password'])
        #errand.image_url=f"/{errand_CONTENT_FOLDER}/{fname}"
        #EDIT image
        image_full=os.path.join(USER_CONTENT_FOLDER, fname)

        # Find the index of "usercont" in the path
        index_of_usercont = image_full.find("usercont")

        # Extract the part of the path starting from "usercont"
        errand.image_url = image_full[index_of_usercont:]
        db.session.commit()
        
        
        return render_template("Errand/errand_profile.html",errand=errand)


@_route_errand.route('/usercont/<path:file>')
def serve_usercont(file):
    return send_from_directory(os.path.abspath(USER_CONTENT_FOLDER), file)

def gen_random_fname(length = 32):
    src = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    return ''.join([src[random.randint(0, len(src) - 1)] for x in range(0, length)])


def handle_profile_submition(file):
    if file.filename == '':
        return None
    fname = f"{gen_random_fname()}{os.path.splitext(file.filename)[1]}"
    file.save(os.path.join(USER_CONTENT_FOLDER, fname))
    return fname 