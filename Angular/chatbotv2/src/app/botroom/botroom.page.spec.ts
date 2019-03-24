import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { BotroomPage } from './botroom.page';

describe('BotroomPage', () => {
  let component: BotroomPage;
  let fixture: ComponentFixture<BotroomPage>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ BotroomPage ],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BotroomPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
